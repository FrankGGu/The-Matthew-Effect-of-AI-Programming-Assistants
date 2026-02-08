typedef struct {
    int time;
    int row;
    int col;
} Cell;

int compare(const void* a, const void* b) {
    return ((Cell*)a)->time - ((Cell*)b)->time;
}

int minTimeToReach(int** moveTime, int moveTimeSize, int* moveTimeColSize) {
    int n = moveTimeSize;
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    Cell* heap = (Cell*)malloc(n * n * sizeof(Cell));
    int heapSize = 0;

    int** dist = (int**)malloc(n * sizeof(int*));
    for (int i = 0; i < n; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    dist[0][0] = 0;
    heap[heapSize].time = 0;
    heap[heapSize].row = 0;
    heap[heapSize].col = 0;
    heapSize++;

    while (heapSize > 0) {
        qsort(heap, heapSize, sizeof(Cell), compare);
        Cell current = heap[0];
        for (int i = 1; i < heapSize; i++) {
            heap[i - 1] = heap[i];
        }
        heapSize--;

        if (current.row == n - 1 && current.col == n - 1) {
            for (int i = 0; i < n; i++) {
                free(dist[i]);
            }
            free(dist);
            free(heap);
            return current.time;
        }

        for (int i = 0; i < 4; i++) {
            int newRow = current.row + directions[i][0];
            int newCol = current.col + directions[i][1];

            if (newRow >= 0 && newRow < n && newCol >= 0 && newCol < n) {
                int newTime = current.time + 1;
                if (newTime < moveTime[newRow][newCol]) {
                    newTime = moveTime[newRow][newCol];
                }

                if (newTime < dist[newRow][newCol]) {
                    dist[newRow][newCol] = newTime;
                    heap[heapSize].time = newTime;
                    heap[heapSize].row = newRow;
                    heap[heapSize].col = newCol;
                    heapSize++;
                }
            }
        }
    }

    for (int i = 0; i < n; i++) {
        free(dist[i]);
    }
    free(dist);
    free(heap);
    return -1;
}