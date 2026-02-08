#include <limits.h> // For INT_MAX
#include <stdlib.h> // For malloc, free

int dr[] = {0, 0, 1, -1};
int dc[] = {1, -1, 0, 0};

typedef struct {
    int r, c;
} Point;

#define MAX_DEQUE_SIZE (100 * 100 + 5) // Max nodes in grid + a small buffer
Point deque[MAX_DEQUE_SIZE];
int head, tail;

void init_deque() {
    head = 0;
    tail = 0;
}

void push_front(Point p) {
    head = (head - 1 + MAX_DEQUE_SIZE) % MAX_DEQUE_SIZE;
    deque[head] = p;
}

void push_back(Point p) {
    deque[tail] = p;
    tail = (tail + 1) % MAX_DEQUE_SIZE;
}

Point pop_front() {
    Point p = deque[head];
    head = (head + 1) % MAX_DEQUE_SIZE;
    return p;
}

int is_empty() {
    return head == tail;
}

int minCost(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; ++j) {
            dist[i][j] = INT_MAX;
        }
    }

    init_deque();

    dist[0][0] = 0;
    push_front((Point){0, 0});

    while (!is_empty()) {
        Point current = pop_front();
        int r = current.r;
        int c = current.c;

        for (int i = 0; i < 4; ++i) { // Iterate over 4 possible directions
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int edge_cost = 1;
                // If the current direction 'i' matches the preferred direction from grid[r][c], cost is 0.
                // grid[r][c] values are 1-4. Map them to 0-3 for dr/dc array indices.
                // 1 -> 0 (right), 2 -> 1 (left), 3 -> 2 (down), 4 -> 3 (up)
                if (i == (grid[r][c] - 1)) {
                    edge_cost = 0;
                }

                int new_cost = dist[r][c] + edge_cost;

                if (new_cost < dist[nr][nc]) {
                    dist[nr][nc] = new_cost;
                    if (edge_cost == 0) {
                        push_front((Point){nr, nc});
                    } else {
                        push_back((Point){nr, nc});
                    }
                }
            }
        }
    }

    int result = dist[m - 1][n - 1];

    for (int i = 0; i < m; ++i) {
        free(dist[i]);
    }
    free(dist);

    return result;
}