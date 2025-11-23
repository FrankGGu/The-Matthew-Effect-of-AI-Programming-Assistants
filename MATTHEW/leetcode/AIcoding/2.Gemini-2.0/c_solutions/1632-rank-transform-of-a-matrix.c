#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int row;
    int col;
    int val;
} Cell;

int compare(const void *a, const void *b) {
    return ((Cell *)a)->val - ((Cell *)b)->val;
}

int* find(int* parent, int i) {
    if (parent[i] == i)
        return &parent[i];
    return parent[i] = *find(parent, parent[i]);
}

void unite(int* parent, int* rank, int x, int y) {
    x = *find(parent, x);
    y = *find(parent, y);
    if (x != y) {
        if (rank[x] < rank[y])
            parent[x] = y;
        else if (rank[x] > rank[y])
            parent[y] = x;
        else {
            parent[y] = x;
            rank[x]++;
        }
    }
}

int** matrixRankTransform(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes){
    int m = matrixSize;
    int n = *matrixColSize;

    int** result = (int**)malloc(m * sizeof(int*));
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        result[i] = (int*)malloc(n * sizeof(int));
        (*returnColumnSizes)[i] = n;
    }

    int* rowRank = (int*)calloc(m, sizeof(int));
    int* colRank = (int*)calloc(n, sizeof(int));

    Cell* cells = (Cell*)malloc(m * n * sizeof(Cell));
    int k = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            cells[k].row = i;
            cells[k].col = j;
            cells[k].val = matrix[i][j];
            k++;
        }
    }

    qsort(cells, m * n, sizeof(Cell), compare);

    int prevVal = -1e9 - 7;
    for (int i = 0; i < m * n; ) {
        int j = i;
        while (j < m * n && cells[i].val == cells[j].val)
            j++;

        int* parent = (int*)malloc((m + n) * sizeof(int));
        int* rank = (int*)calloc(m + n, sizeof(int));
        for (int x = 0; x < m + n; x++)
            parent[x] = x;

        int* maxRank = (int*)malloc((m + n) * sizeof(int));
        for (int x = 0; x < m + n; x++)
            maxRank[x] = 0;

        for (int x = i; x < j; x++) {
            int row = cells[x].row;
            int col = cells[x].col + m;
            unite(parent, rank, row, col);
        }

        for (int x = i; x < j; x++) {
            int row = cells[x].row;
            int col = cells[x].col + m;
            int p = *find(parent, row);
            maxRank[p] = (rowRank[row] > colRank[cells[x].col] ? rowRank[row] : colRank[cells[x].col]);
        }

        for (int x = i; x < j; x++) {
            int row = cells[x].row;
            int col = cells[x].col;
            int p = *find(parent, row);
            int newRank = maxRank[p] + 1;
            rowRank[row] = newRank;
            colRank[col] = newRank;
            result[row][col] = newRank;
        }

        free(parent);
        free(rank);
        free(maxRank);
        i = j;
    }

    free(cells);
    free(rowRank);
    free(colRank);

    *returnSize = m;
    return result;
}