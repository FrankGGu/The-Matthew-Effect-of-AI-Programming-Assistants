typedef struct {
    int x, y;
} Point;

typedef struct {
    Point *points;
    int size;
} UnionFind;

UnionFind* createUnionFind(int n) {
    UnionFind *uf = (UnionFind *)malloc(sizeof(UnionFind));
    uf->points = (Point *)malloc(n * sizeof(Point));
    uf->size = n;
    for (int i = 0; i < n; i++) {
        uf->points[i].x = i;
        uf->points[i].y = 0;
    }
    return uf;
}

int find(UnionFind *uf, int idx) {
    if (uf->points[idx].x != idx) {
        uf->points[idx].x = find(uf, uf->points[idx].x);
    }
    return uf->points[idx].x;
}

void unionSets(UnionFind *uf, int idx1, int idx2) {
    int root1 = find(uf, idx1);
    int root2 = find(uf, idx2);
    if (root1 != root2) {
        uf->points[root1].x = root2;
    }
}

bool isConnected(UnionFind *uf, int idx1, int idx2) {
    return find(uf, idx1) == find(uf, idx2);
}

int popBubbles(int** board, int boardSize, int* boardColSize, int** hits, int hitsSize, int* returnSize) {
    int rows = boardSize, cols = *boardColSize;
    UnionFind *uf = createUnionFind(rows * cols + 1);
    int totalBubbles = 0;

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (board[i][j] == 1) {
                totalBubbles++;
                if (i == 0) {
                    unionSets(uf, j, rows * cols);
                }
                if (i > 0 && board[i - 1][j] == 1) {
                    unionSets(uf, i * cols + j, (i - 1) * cols + j);
                }
                if (j > 0 && board[i][j - 1] == 1) {
                    unionSets(uf, i * cols + j, i * cols + (j - 1));
                }
            }
        }
    }

    int *result = (int *)malloc(hitsSize * sizeof(int));
    for (int i = hitsSize - 1; i >= 0; i--) {
        int hitRow = hits[i][0], hitCol = hits[i][1];
        if (board[hitRow][hitCol] == 1) {
            board[hitRow][hitCol] = 0;
            totalBubbles--;
            if (hitRow == 0) {
                unionSets(uf, hitCol, rows * cols);
            }
            if (hitRow > 0 && board[hitRow - 1][hitCol] == 1) {
                unionSets(uf, hitRow * cols + hitCol, (hitRow - 1) * cols + hitCol);
            }
            if (hitCol > 0 && board[hitRow][hitCol - 1] == 1) {
                unionSets(uf, hitRow * cols + hitCol, hitRow * cols + (hitCol - 1));
            }
            if (hitCol < cols - 1 && board[hitRow][hitCol + 1] == 1) {
                unionSets(uf, hitRow * cols + hitCol, hitRow * cols + (hitCol + 1));
            }
            if (hitRow < rows - 1 && board[hitRow + 1][hitCol] == 1) {
                unionSets(uf, hitRow * cols + hitCol, (hitRow + 1) * cols + hitCol);
            }
            if (isConnected(uf, hitCol, rows * cols)) {
                result[i] = totalBubbles + 1;
            } else {
                result[i] = totalBubbles;
            }
        } else {
            result[i] = totalBubbles;
        }
    }

    *returnSize = hitsSize;
    free(uf->points);
    free(uf);
    return result;
}