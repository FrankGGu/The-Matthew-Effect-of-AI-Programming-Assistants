#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int* parent;
    int* rank;
    int size;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind* uf = (UnionFind*)malloc(sizeof(UnionFind));
    uf->parent = (int*)malloc(n * sizeof(int));
    uf->rank = (int*)malloc(n * sizeof(int));
    uf->size = n;
    for (int i = 0; i < n; i++) {
        uf->parent[i] = i;
        uf->rank[i] = 1;
    }
    return uf;
}

int find(UnionFind* uf, int x) {
    if (uf->parent[x] != x) {
        uf->parent[x] = find(uf, uf->parent[x]);
    }
    return uf->parent[x];
}

void unionSet(UnionFind* uf, int x, int y) {
    int rootX = find(uf, x);
    int rootY = find(uf, y);
    if (rootX != rootY) {
        if (uf->rank[rootX] > uf->rank[rootY]) {
            uf->parent[rootY] = rootX;
        } else {
            uf->parent[rootX] = rootY;
            if (uf->rank[rootX] == uf->rank[rootY]) {
                uf->rank[rootY]++;
            }
        }
    }
}

int getIdx(int x, int y, int cols) {
    return x * cols + y;
}

int* hitBricks(int** grid, int gridSize, int* gridColSize, int** hits, int hitsSize, int* hitsColSize, int* returnSize) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int total = rows * cols;
    int* result = (int*)malloc(hitsSize * sizeof(int));
    int* brickCount = (int*)calloc(total, sizeof(int));
    int* visited = (int*)calloc(total, sizeof(int));

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                brickCount[getIdx(i, j, cols)] = 1;
            }
        }
    }

    UnionFind* uf = createUnionFind(total);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int idx = getIdx(i, j, cols);
                if (i > 0 && grid[i - 1][j] == 1) {
                    unionSet(uf, idx, getIdx(i - 1, j, cols));
                }
                if (j > 0 && grid[i][j - 1] == 1) {
                    unionSet(uf, idx, getIdx(i, j - 1, cols));
                }
            }
        }
    }

    int* rootCount = (int*)calloc(total, sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                int idx = getIdx(i, j, cols);
                int root = find(uf, idx);
                rootCount[root]++;
            }
        }
    }

    int* tempGrid = (int*)malloc(rows * cols * sizeof(int));
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            tempGrid[getIdx(i, j, cols)] = grid[i][j];
        }
    }

    for (int k = 0; k < hitsSize; k++) {
        int x = hits[k][0];
        int y = hits[k][1];
        if (x < 0 || x >= rows || y < 0 || y >= cols || tempGrid[getIdx(x, y, cols)] == 0) {
            result[k] = 0;
            continue;
        }
        tempGrid[getIdx(x, y, cols)] = 0;
        int count = 0;
        int root = find(uf, getIdx(x, y, cols));
        if (x == 0) {
            count = 0;
        } else {
            int up = getIdx(x - 1, y, cols);
            if (tempGrid[up] == 1) {
                int rootUp = find(uf, up);
                if (rootUp != root) {
                    count += rootCount[rootUp];
                }
            }
        }
        if (y > 0) {
            int left = getIdx(x, y - 1, cols);
            if (tempGrid[left] == 1) {
                int rootLeft = find(uf, left);
                if (rootLeft != root) {
                    count += rootCount[rootLeft];
                }
            }
        }
        if (y < cols - 1) {
            int right = getIdx(x, y + 1, cols);
            if (tempGrid[right] == 1) {
                int rootRight = find(uf, right);
                if (rootRight != root) {
                    count += rootCount[rootRight];
                }
            }
        }
        if (x < rows - 1) {
            int down = getIdx(x + 1, y, cols);
            if (tempGrid[down] == 1) {
                int rootDown = find(uf, down);
                if (rootDown != root) {
                    count += rootCount[rootDown];
                }
            }
        }
        result[k] = count;
    }

    free(visited);
    free(brickCount);
    free(tempGrid);
    free(rootCount);
    free(uf->parent);
    free(uf->rank);
    free(uf);
    *returnSize = hitsSize;
    return result;
}