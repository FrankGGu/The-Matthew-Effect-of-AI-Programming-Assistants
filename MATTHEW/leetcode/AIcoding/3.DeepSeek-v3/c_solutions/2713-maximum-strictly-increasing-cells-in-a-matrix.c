typedef struct {
    int val;
    int row;
    int col;
} Cell;

int cmp(const void* a, const void* b) {
    Cell* ca = (Cell*)a;
    Cell* cb = (Cell*)b;
    return ca->val - cb->val;
}

int maxIncreasingCells(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];

    Cell* cells = (Cell*)malloc(m * n * sizeof(Cell));
    int idx = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            cells[idx].val = mat[i][j];
            cells[idx].row = i;
            cells[idx].col = j;
            idx++;
        }
    }

    qsort(cells, m * n, sizeof(Cell), cmp);

    int* rowMax = (int*)calloc(m, sizeof(int));
    int* colMax = (int*)calloc(n, sizeof(int));
    int* dp = (int*)malloc(m * n * sizeof(int));

    int result = 0;
    int start = 0;

    for (int i = 0; i < m * n; i++) {
        if (i > 0 && cells[i].val != cells[i - 1].val) {
            for (int j = start; j < i; j++) {
                int r = cells[j].row;
                int c = cells[j].col;
                int pos = r * n + c;
                rowMax[r] = fmax(rowMax[r], dp[pos]);
                colMax[c] = fmax(colMax[c], dp[pos]);
            }
            start = i;
        }

        int r = cells[i].row;
        int c = cells[i].col;
        int pos = r * n + c;
        dp[pos] = fmax(rowMax[r], colMax[c]) + 1;
        result = fmax(result, dp[pos]);
    }

    free(cells);
    free(rowMax);
    free(colMax);
    free(dp);

    return result;
}