#include <stdlib.h>
#include <limits.h>

typedef struct {
    int r;
    int c;
} Cell;

Cell queue[10000];
int head = 0;
int tail = 0;

void enqueue(int r, int c) {
    queue[tail].r = r;
    queue[tail].c = c;
    tail++;
}

Cell dequeue() {
    return queue[head++];
}

int is_empty() {
    return head == tail;
}

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int** updateMatrix(int** mat, int matSize, int* matColSize) {
    int m = matSize;
    int n = matColSize[0];

    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
    }

    head = 0;
    tail = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (mat[i][j] == 0) {
                dist[i][j] = 0;
                enqueue(i, j);
            } else {
                dist[i][j] = INT_MAX;
            }
        }
    }

    while (!is_empty()) {
        Cell current = dequeue();
        int r = current.r;
        int c = current.c;

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                if (dist[nr][nc] > dist[r][c] + 1) {
                    dist[nr][nc] = dist[r][c] + 1;
                    enqueue(nr, nc);
                }
            }
        }
    }

    return dist;
}