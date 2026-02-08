int* prisonAfterNDays(int* cells, int cellsSize, int n, int* returnSize) {
    *returnSize = cellsSize;
    int* next = (int*)malloc(cellsSize * sizeof(int));
    int* firstState = (int*)malloc(cellsSize * sizeof(int));

    n = n % 14 == 0 ? 14 : n % 14;

    for (int day = 0; day < n; day++) {
        for (int i = 0; i < cellsSize; i++) {
            if (i == 0 || i == cellsSize - 1) {
                next[i] = 0;
            } else {
                next[i] = (cells[i - 1] == cells[i + 1]) ? 1 : 0;
            }
        }

        if (day == 0) {
            memcpy(firstState, next, cellsSize * sizeof(int));
        }

        memcpy(cells, next, cellsSize * sizeof(int));
    }

    free(next);
    free(firstState);
    return cells;
}