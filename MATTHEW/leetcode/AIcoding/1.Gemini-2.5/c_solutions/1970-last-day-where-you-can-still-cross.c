#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int r, c;
} Point;

static Point bfs_queue[200005]; 
static int bfs_head;
static int bfs_tail;

static void enqueue(int r, int c) {
    bfs_queue[bfs_tail].r = r;
    bfs_queue[bfs_tail].c = c;
    bfs_tail++;
}

static Point dequeue() {
    return bfs_queue[bfs_head++];
}

static bool is_empty() {
    return bfs_head == bfs_tail;
}

static bool canCross(int day, int R, int C, int** cells) {
    bool* is_water = (bool*)calloc(R * C, sizeof(bool));
    if (!is_water) return false;

    for (int i = 0; i < day; i++) {
        is_water[(cells[i][0] - 1) * C + (cells[i][1] - 1)] = true;
    }

    bfs_head = 0;
    bfs_tail = 0;
    bool* visited = (bool*)calloc(R * C, sizeof(bool));
    if (!visited) {
        free(is_water);
        return false;
    }

    for (int j = 0; j < C; j++) {
        if (!is_water[0 * C + j]) {
            enqueue(0, j);
            visited[0 * C + j] = true;
        }
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (!is_empty()) {
        Point current = dequeue();
        int r = current.r;
        int c = current.c;

        if (r == R - 1) {
            free(is_water);
            free(visited);
            return true;
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < R && nc >= 0 && nc < C &&
                !is_water[nr * C + nc] && !visited[nr * C + nc]) {
                visited[nr * C + nc] = true;
                enqueue(nr, nc);
            }
        }
    }

    free(is_water);
    free(visited);
    return false;
}

int latestDayToCross(int row, int col, int** cells, int cellsSize, int* cellsColSize) {
    int low = 1;
    int high = row * col;
    int ans = 0;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (canCross(mid, row, col, cells)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }
    return ans;
}