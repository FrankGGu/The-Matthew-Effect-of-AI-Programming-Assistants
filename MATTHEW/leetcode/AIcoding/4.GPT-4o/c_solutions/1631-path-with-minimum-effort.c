int minimumEffortPath(int** heights, int heightsSize, int* heightsColSize) {
    int rows = heightsSize, cols = heightsColSize[0];
    int directions[4][2] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};
    int** effort = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        effort[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            effort[i][j] = INT_MAX;
        }
    }
    effort[0][0] = 0;

    typedef struct {
        int x, y, cost;
    } Node;

    Node* heap = (Node*)malloc(rows * cols * sizeof(Node));
    int heapSize = 0;
    heap[heapSize++] = (Node){0, 0, 0};

    while (heapSize > 0) {
        Node current = heap[--heapSize];

        if (current.x == rows - 1 && current.y == cols - 1) {
            free(heap);
            for (int i = 0; i < rows; i++) free(effort[i]);
            free(effort);
            return current.cost;
        }

        for (int i = 0; i < 4; i++) {
            int newX = current.x + directions[i][0];
            int newY = current.y + directions[i][1];

            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols) {
                int nextCost = abs(heights[newX][newY] - heights[current.x][current.y]);
                int maxEffort = current.cost > nextCost ? current.cost : nextCost;

                if (maxEffort < effort[newX][newY]) {
                    effort[newX][newY] = maxEffort;
                    heap[heapSize++] = (Node){newX, newY, maxEffort};
                }
            }
        }
    }

    free(heap);
    for (int i = 0; i < rows; i++) free(effort[i]);
    free(effort);
    return 0;
}