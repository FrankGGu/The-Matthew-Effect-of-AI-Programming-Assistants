#include <stdlib.h>
#include <string.h>
#include <stdbool.h>

#define MAX_DIM 30
#define MAX_KEYS 6
#define MAX_QUEUE_SIZE (MAX_DIM * MAX_DIM * (1 << MAX_KEYS))

typedef struct {
    int r;
    int c;
    int keys;
    int steps;
} State;

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

bool visited[MAX_DIM][MAX_DIM][1 << MAX_KEYS];
State queue[MAX_QUEUE_SIZE];
int head = 0;
int tail = 0;

void enqueue(int r, int c, int keys, int steps) {
    queue[tail].r = r;
    queue[tail].c = c;
    queue[tail].keys = keys;
    queue[tail].steps = steps;
    tail++;
}

State dequeue() {
    return queue[head++];
}

bool is_empty() {
    return head == tail;
}

int shortestPathAllKeys(char** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int start_r, start_c;
    int all_keys_mask = 0;

    for (int i = 0; i < m; i++) {
        for (int j = 0; j < n; j++) {
            if (grid[i][j] == '@') {
                start_r = i;
                start_c = j;
            } else if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                all_keys_mask |= (1 << (grid[i][j] - 'a'));
            }
        }
    }

    memset(visited, 0, sizeof(visited));
    head = 0;
    tail = 0;

    enqueue(start_r, start_c, 0, 0);
    visited[start_r][start_c][0] = true;

    while (!is_empty()) {
        State current = dequeue();

        if (current.keys == all_keys_mask) {
            return current.steps;
        }

        for (int i = 0; i < 4; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];
            int new_keys = current.keys;

            if (nr < 0 || nr >= m || nc < 0 || nc >= n) {
                continue;
            }

            char cell = grid[nr][nc];

            if (cell == '#') {
                continue;
            }

            if (cell >= 'a' && cell <= 'f') {
                new_keys |= (1 << (cell - 'a'));
            } else if (cell >= 'A' && cell <= 'F') {
                if (!((current.keys >> (cell - 'A')) & 1)) {
                    continue;
                }
            }

            if (!visited[nr][nc][new_keys]) {
                visited[nr][nc][new_keys] = true;
                enqueue(nr, nc, new_keys, current.steps + 1);
            }
        }
    }

    return -1;
}