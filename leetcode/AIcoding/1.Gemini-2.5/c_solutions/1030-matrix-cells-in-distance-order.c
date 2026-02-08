#include <stdlib.h>

typedef struct {
    int r;
    int c;
    int dist;
} CellInfo;

int compareCellInfo(const void *a, const void *b) {
    CellInfo *cellA = (CellInfo *)a;
    CellInfo *cellB = (CellInfo *)b;
    return cellA->dist - cellB->dist;
}

int** allCellsDistOrder(int R, int C, int r0, int c0, int* returnSize, int** returnColumnSizes) {
    *returnSize = R * C;

    CellInfo *cells = (CellInfo *)malloc(*returnSize * sizeof(CellInfo));
    if (cells == NULL) {
        return NULL;
    }

    int idx = 0;
    for (int r = 0; r < R; r++) {
        for (int c = 0; c < C; c++) {
            cells[idx].r = r;
            cells[idx].c = c;
            cells[idx].dist = abs(r - r0) + abs(c - c0);
            idx++;
        }
    }

    qsort(cells, *returnSize, sizeof(CellInfo), compareCellInfo);

    int** result = (int**)malloc(*returnSize * sizeof(int*));
    if (result == NULL) {
        free(cells);
        return NULL;
    }

    *returnColumnSizes = (int*)malloc(*returnSize * sizeof(int));
    if (*returnColumnSizes == NULL) {
        free(cells);
        free(result);
        return NULL;
    }

    for (int i = 0; i < *returnSize; i++) {
        result[i] = (int*)malloc(2 * sizeof(int));
        if (result[i] == NULL) {
            for (int j = 0; j < i; j++) {
                free(result[j]);
            }
            free(result);
            free(*returnColumnSizes);
            free(cells);
            return NULL;
        }
        result[i][0] = cells[i].r;
        result[i][1] = cells[i].c;
        (*returnColumnSizes)[i] = 2;
    }

    free(cells);

    return result;
}