typedef struct {
    int val;
    int row;
    int col;
} Element;

typedef struct {
    int parent;
    int size;
} UnionFind;

int find(UnionFind* uf, int x) {
    if (uf[x].parent != x) {
        uf[x].parent = find(uf, uf[x].parent);
    }
    return uf[x].parent;
}

void unite(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf[rootX].size < uf[rootY].size) {
            uf[rootX].parent = rootY;
            uf[rootY].size += uf[rootX].size;
        } else {
            uf[rootY].parent = rootX;
            uf[rootX].size += uf[rootY].size;
        }
    }
}

int cmp(const void* a, const void* b) {
    return ((Element*)a)->val - ((Element*)b)->val;
}

int** matrixRankTransform(int** matrix, int matrixSize, int* matrixColSize, int* returnSize, int** returnColumnSizes) {
    int m = matrixSize;
    int n = matrixColSize[0];

    Element* elements = (Element*)malloc(m * n * sizeof(Element));
    int idx = 0;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            elements[idx].val = matrix[i][j];
            elements[idx].row = i;
            elements[idx].col = j;
            idx++;
        }
    }

    qsort(elements, m * n, sizeof(Element), cmp);

    int* rowMax = (int*)calloc(m, sizeof(int));
    int* colMax = (int*)calloc(n, sizeof(int));
    int** rank = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        rank[i] = (int*)calloc(n, sizeof(int));
    }

    UnionFind* uf = (UnionFind*)malloc(m * n * sizeof(UnionFind));
    for (int i = 0; i < m * n; i++) {
        uf[i].parent = i;
        uf[i].size = 1;
    }

    for (int i = 0; i < m * n; ) {
        int j = i;
        while (j < m * n && elements[j].val == elements[i].val) {
            j++;
        }

        for (int k = i; k < j; k++) {
            int r = elements[k].row;
            int c = elements[k].col;
            int idx1 = r * n + c;
            for (int k2 = i; k2 < j; k2++) {
                int r2 = elements[k2].row;
                int c2 = elements[k2].col;
                if (r == r2 || c == c2) {
                    int idx2 = r2 * n + c2;
                    unite(uf, idx1, idx2);
                }
            }
        }

        for (int k = i; k < j; k++) {
            int r = elements[k].row;
            int c = elements[k].col;
            int root = find(uf, r * n + c);
            int currentRank = 1;
            if (rowMax[r] > currentRank) currentRank = rowMax[r];
            if (colMax[c] > currentRank) currentRank = colMax[c];
            rank[r][c] = currentRank;
        }

        for (int k = i; k < j; k++) {
            int r = elements[k].row;
            int c = elements[k].col;
            int root = find(uf, r * n + c);
            int currentRank = rank[r][c];
            for (int k2 = i; k2 < j; k2++) {
                int r2 = elements[k2].row;
                int c2 = elements[k2].col;
                if (find(uf, r2 * n + c2) == root) {
                    if (currentRank > rank[r2][c2]) {
                        rank[r2][c2] = currentRank;
                    }
                }
            }
        }

        for (int k = i; k < j; k++) {
            int r = elements[k].row;
            int c = elements[k].col;
            int currentRank = rank[r][c];
            if (currentRank > rowMax[r]) rowMax[r] = currentRank;
            if (currentRank > colMax[c]) colMax[c] = currentRank;
        }

        i = j;
    }

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            matrix[i][j] = rank[i][j];
        }
    }

    free(elements);
    free(rowMax);
    free(colMax);
    for (int i = 0; i < m; i++) {
        free(rank[i]);
    }
    free(rank);
    free(uf);

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }
    return matrix;
}