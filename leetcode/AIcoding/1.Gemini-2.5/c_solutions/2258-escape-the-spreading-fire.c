#include <stdbool.h>
#include <stdlib.h>
#include <string.h>
#include <limits.h>

int dr[] = {0, 0, 1, -1};
int dc[] = {1, -1, 0, 0};

typedef struct {
    int r, c, t;
} State;

#define MAX_GRID_AREA (200 * 200)
#define MAX_QUEUE_SIZE (MAX_GRID_AREA * 2) 

State queue[MAX_QUEUE_SIZE];
int head, tail;

void init_queue() {
    head = 0;
    tail = 0;
}

void enqueue(int r, int c, int t) {
    queue[tail].r = r;
    queue[tail].c = c;
    queue[tail].t = t;
    tail = (tail + 1) % MAX_QUEUE_SIZE;
}

State dequeue() {
    State s = queue[head];
    head = (head + 1) % MAX_QUEUE_SIZE;
    return s;
}

bool is_queue_empty() {
    return head == tail;
}

int M_global, N_global;
int** Grid_global;
int** fire_time_global;

void precompute_fire_spread(int m, int n, int** grid) {
    M_global = m;
    N_global = n;
    Grid_global = grid;

    fire_time_global = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        fire_time_global[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; ++j) {
            fire_time_global[i][j] = INT_MAX;
        }
    }

    init_queue();

    for (int r = 0; r < m; ++r) {
        for (int c = 0; c < n; ++c) {
            if (grid[r][c] == 1) {
                enqueue(r, c, 0);
                fire_time_global[r][c] = 0;
            }
        }
    }

    while (!is_queue_empty()) {
        State current = dequeue();

        for (int i = 0; i < 4; ++i) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];
            int next_t = current.t + 1;

            if (nr >= 0 && nr < M_global && nc >= 0 && nc < N_global &&
                Grid_global[nr][nc] != 2 && 
                next_t < fire_time_global[nr][nc]) {
                fire_time_global[nr][nc] = next_t;
                enqueue(nr, nc, next_t);
            }
        }
    }
}

bool can_reach(int wait_time) {
    if (Grid_global[0][0] == 2 || Grid_global[M_global-1][N_global-1] == 2) {
        return false;
    }

    if (wait_time >= fire_time_global[0][0]) {
        return false;
    }

    init_queue();
    enqueue(0, 0, wait_time); 

    bool visited[200][200]; 
    for (int i = 0; i < M_global; ++i) {
        for (int j = 0; j < N_global; ++j) {
            visited[i][j] = false;
        }
    }
    visited[0][0] = true;

    while (!is_queue_empty()) {
        State current = dequeue();

        if (current.r == M_global - 1 && current.c == N_global - 1) {
            return current.t < fire_time_global[M_global-1][N_global-1];
        }

        for (int i = 0; i < 4; ++i) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];
            int next_player_t = current.t + 1;

            if (nr >= 0 && nr < M_global && nc >= 0 && nc < N_global &&
                Grid_global[nr][nc] != 2 && 
                !visited[nr][nc]) {

                if (next_player_t < fire_time_global[nr][nc]) {
                    visited[nr][nc] = true;
                    enqueue(nr, nc, next_player_t);
                }
            }
        }
    }
    return false;
}

int maximumMinutes(int** grid, int gridSize, int* gridColSize) {
    precompute_fire_spread(gridSize, gridColSize[0], grid);

    int low = 0;
    int high = M_global * N_global + 1;
    int ans = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (can_reach(mid)) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    for (int i = 0; i < M_global; ++i) {
        free(fire_time_global[i]);
    }
    free(fire_time_global);

    if (ans == M_global * N_global + 1) {
        return 1000000000;
    }

    return ans;
}