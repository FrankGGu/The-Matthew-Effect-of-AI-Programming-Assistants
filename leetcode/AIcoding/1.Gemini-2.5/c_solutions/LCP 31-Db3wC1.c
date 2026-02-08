#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

#define MAX_M 50
#define MAX_N 50
#define MAX_K_VAL 100

typedef struct {
    int r, c, time;
} State;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

bool visited[MAX_M][MAX_N][MAX_K_VAL];

State queue[MAX_M * MAX_N * MAX_K_VAL];
int head, tail;

bool isTraversable(int r, int c, int time, int k, int** grid, int m, int n) {
    if (r < 0 || r >= m || c < 0 || c >= n) {
        return false;
    }
    return (grid[r][c] + (time / k)) % 2 == 0;
}

int transformingMaze(int** grid, int gridSize, int* gridColSize, int k) {
    int m = gridSize;
    int n = gridColSize[0];

    memset(visited, 0, sizeof(visited));

    head = 0;
    tail = 0;

    if (!isTraversable(0, 0, 0, k, grid, m, n)) {
        return -1;
    }

    State startState = {0, 0, 0};
    queue[tail++] = startState;
    visited[0][0][0 % k] = true;

    while (head < tail) {
        State current = queue[head++];

        if (current.r == m - 1 && current.c == n - 1) {
            return current.time;
        }

        for (int i = 0; i < 4; ++i) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];
            int ntime = current.time + 1;

            if (isTraversable(nr, nc, ntime, k, grid, m, n)) {
                if (!visited[nr][nc][ntime % k]) {
                    visited[nr][nc][ntime % k] = true;
                    State nextState = {nr, nc, ntime};
                    queue[tail++] = nextState;
                }
            }
        }
    }

    return -1;
}