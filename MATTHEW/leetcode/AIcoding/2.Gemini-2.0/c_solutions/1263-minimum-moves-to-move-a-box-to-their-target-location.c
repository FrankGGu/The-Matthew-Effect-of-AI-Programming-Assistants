#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_SIZE 20

typedef struct {
    int px, py, bx, by, moves;
} State;

int minPushBox(char grid[][MAX_SIZE], int m, int n) {
    int start_px, start_py, start_bx, start_by, target_bx, target_by;
    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == 'S') {
                start_px = i;
                start_py = j;
            } else if (grid[i][j] == 'B') {
                start_bx = i;
                start_by = j;
            } else if (grid[i][j] == 'T') {
                target_bx = i;
                target_by = j;
            }
        }
    }

    int dx[] = {0, 0, 1, -1};
    int dy[] = {1, -1, 0, 0};

    bool visited[MAX_SIZE][MAX_SIZE][MAX_SIZE][MAX_SIZE] = {false};
    State queue[m * n * m * n];
    int head = 0, tail = 0;
    queue[tail++] = (State){start_px, start_py, start_bx, start_by, 0};
    visited[start_px][start_py][start_bx][start_by] = true;

    while (head < tail) {
        State curr = queue[head++];
        int px = curr.px, py = curr.py, bx = curr.bx, by = curr.by, moves = curr.moves;

        if (bx == target_bx && by == target_by) {
            return moves;
        }

        for (int i = 0; i < 4; i++) {
            int npx = px + dx[i];
            int npy = py + dy[i];

            if (npx < 0 || npx >= m || npy < 0 || npy >= n || grid[npx][npy] == '#') {
                continue;
            }

            if (npx == bx && npy == by) {
                int nbx = bx + dx[i];
                int nby = by + dy[i];

                if (nbx < 0 || nbx >= m || nby < 0 || nby >= n || grid[nbx][nby] == '#') {
                    continue;
                }

                if (!visited[npx][npy][nbx][nby]) {
                    visited[npx][npy][nbx][nby] = true;
                    queue[tail++] = (State){npx, npy, nbx, nby, moves + 1};
                }
            } else {
                if (!visited[npx][npy][bx][by]) {
                    visited[npx][npy][bx][by] = true;
                    queue[tail++] = (State){npx, npy, bx, by, moves};
                }
            }
        }
    }

    return -1;
}