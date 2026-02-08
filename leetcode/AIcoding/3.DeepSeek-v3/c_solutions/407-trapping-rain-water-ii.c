typedef struct {
    int x, y, h;
} Cell;

int cmp(const void* a, const void* b) {
    return ((Cell*)a)->h - ((Cell*)b)->h;
}

int trapRainWater(int** heightMap, int heightMapSize, int* heightMapColSize) {
    if (heightMapSize < 3 || heightMapColSize[0] < 3) return 0;

    int m = heightMapSize, n = heightMapColSize[0];
    int visited[200][200] = {0};
    Cell* heap = (Cell*)malloc(m * n * sizeof(Cell));
    int heapSize = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (i == 0 || i == m - 1 || j == 0 || j == n - 1) {
                heap[heapSize++] = (Cell){i, j, heightMap[i][j]};
                visited[i][j] = 1;
            }
        }
    }

    qsort(heap, heapSize, sizeof(Cell), cmp);

    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int res = 0;
    int minHeight = 0;

    while (heapSize > 0) {
        Cell cell = heap[0];
        for (int i = 0; i < heapSize - 1; i++) {
            heap[i] = heap[i + 1];
        }
        heapSize--;

        if (cell.h > minHeight) {
            minHeight = cell.h;
        }

        for (int k = 0; k < 4; k++) {
            int x = cell.x + dirs[k][0];
            int y = cell.y + dirs[k][1];

            if (x >= 0 && x < m && y >= 0 && y < n && !visited[x][y]) {
                visited[x][y] = 1;
                if (heightMap[x][y] < minHeight) {
                    res += minHeight - heightMap[x][y];
                }

                int insertPos = heapSize;
                heap[heapSize++] = (Cell){x, y, heightMap[x][y]};

                while (insertPos > 0 && heap[insertPos].h < heap[(insertPos - 1) / 2].h) {
                    Cell temp = heap[insertPos];
                    heap[insertPos] = heap[(insertPos - 1) / 2];
                    heap[(insertPos - 1) / 2] = temp;
                    insertPos = (insertPos - 1) / 2;
                }
            }
        }
    }

    free(heap);
    return res;
}