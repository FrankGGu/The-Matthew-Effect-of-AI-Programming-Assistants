#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int r;
    int c;
    int k_left;
    int steps;
} State;

#define MAX_QUEUE_SIZE 2561600

State queue[MAX_QUEUE_SIZE];
int head = 0;
int tail = 0;

void enqueue(State s) {
    queue[tail] = s;
    tail = (tail + 1) % MAX_QUEUE_SIZE;
}

State dequeue() {
    State s = queue[head];
    head = (head + 1) % MAX_QUEUE_SIZE;
    return s;
}

bool is_empty() {
    return head == tail;
}

int shortestPath(int** grid, int gridSize, int* gridColSize, int k) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 1 && n == 1) {
        return 0;
    }

    bool*** visited = (bool***)malloc(m * sizeof(bool**));
    for (int i = 0; i < m; ++i) {
        visited[i] = (bool**)malloc(n * sizeof(bool*));
        for (int j = 0; j < n; ++j) {
            visited[i][j] = (bool*)calloc(k + 1, sizeof(bool));
        }
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    head = 0;
    tail = 0;

    State initial_state = {0, 0, k, 0};
    enqueue(initial_state);
    visited[0][0][k] = true;

    while (!is_empty()) {
        State current = dequeue();

        if (current.r == m - 1 && current.c == n - 1) {
            for (int i = 0; i < m; ++i) {
                for (int j = 0; j < n; ++j) {
                    free(visited[i][j]);
                }
                free(visited[i]);
            }
            free(visited);
            return current.steps;
        }

        for (int i = 0; i < 4; ++i) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int new_k_left = current.k_left;
                if (grid[nr][nc] == 1) {
                    new_k_left--;
                }

                if (new_k_left >= 0 && !visited[nr][nc][new_k_left]) {
                    visited[nr][nc][new_k_left] = true;
                    State next_state = {nr, nc, new_k_left, current.steps + 1};
                    enqueue(next_state);
                }
            }
        }
    }

    for (int i = 0; i < m; ++i) {
        for (int j = 0; j < n; ++j) {
            free(visited[i][j]);
        }
        free(visited[i]);
    }
    free(visited);
    return -1;
}