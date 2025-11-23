typedef struct {
    int x;
    int y;
    int effort;
} Node;

int cmp(const void* a, const void* b) {
    return ((Node*)a)->effort - ((Node*)b)->effort;
}

int minimumEffortPath(int** heights, int heightsSize, int* heightsColSize) {
    int rows = heightsSize;
    int cols = heightsColSize[0];

    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    int** effort = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        effort[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            effort[i][j] = INT_MAX;
        }
    }
    effort[0][0] = 0;

    Node* heap = (Node*)malloc(rows * cols * sizeof(Node));
    int heapSize = 0;

    heap[heapSize].x = 0;
    heap[heapSize].y = 0;
    heap[heapSize].effort = 0;
    heapSize++;

    while (heapSize > 0) {
        Node current = heap[0];
        heap[0] = heap[--heapSize];
        qsort(heap, heapSize, sizeof(Node), cmp);

        if (current.x == rows - 1 && current.y == cols - 1) {
            break;
        }

        if (current.effort > effort[current.x][current.y]) {
            continue;
        }

        for (int i = 0; i < 4; i++) {
            int nx = current.x + directions[i][0];
            int ny = current.y + directions[i][1];

            if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                int new_effort = fmax(current.effort, abs(heights[current.x][current.y] - heights[nx][ny]));

                if (new_effort < effort[nx][ny]) {
                    effort[nx][ny] = new_effort;
                    heap[heapSize].x = nx;
                    heap[heapSize].y = ny;
                    heap[heapSize].effort = new_effort;
                    heapSize++;
                }
            }
        }
    }

    int result = effort[rows - 1][cols - 1];

    for (int i = 0; i < rows; i++) {
        free(effort[i]);
    }
    free(effort);
    free(heap);

    return result;
}