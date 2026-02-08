#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct {
    int r, c;
    int scrolls_used;
    int steps;
} State;

typedef struct {
    State *data;
    int front, rear, size, capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->capacity = capacity;
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->data = (State*)malloc(q->capacity * sizeof(State));
    return q;
}

void enqueue(Queue* q, State s) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (State*)realloc(q->data, q->capacity * sizeof(State));
    }
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = s;
    q->size++;
}

State dequeue(Queue* q) {
    State s = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return s;
}

bool isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

int minStepsToReachEnd(int** grid, int gridSize, int* gridColSize, int K) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return -1;
    }

    int R = gridSize;
    int C = gridColSize[0];

    // If start or end is an obstacle, it's impossible to reach without special handling
    // (e.g., if a scroll can start/end on an obstacle).
    // Assuming (0,0) and (R-1, C-1) are always empty (0) or can be reached/left via scroll.
    // If the target is an obstacle, it's unreachable.
    if (grid[R-1][C-1] == 1) {
        return -1;
    }
    // If start is an obstacle, and no scroll can be used at start, it's unreachable.
    // Assuming start (0,0) is always valid to begin.
    if (grid[0][0] == 1 && (R != 1 || C != 1)) { // If it's a 1x1 grid and start is 1, it's impossible.
                                                // Otherwise, if start is 1, you can't start.
                                                // This specific check might be too strict without problem details.
                                                // For now, assume grid[0][0] is always 0 or we can use a scroll from it.
                                                // The BFS starts from (0,0,0,0) implicitly assuming it's reachable.
    }

    // dist[r][c][scrolls_used] stores the minimum steps
    // Initialize with a large value
    int*** dist = (int***)malloc(R * sizeof(int**));
    for (int i = 0; i < R; i++) {
        dist[i] = (int**)malloc(C * sizeof(int*));
        for (int j = 0; j < C; j++) {
            dist[i][j] = (int*)malloc((K + 1) * sizeof(int));
            for (int k = 0; k <= K; k++) {
                dist[i][j][k] = INT_MAX;
            }
        }
    }

    Queue* q = createQueue(R * C * (K + 1));

    // Initial state: (0, 0, 0 scrolls used, 0 steps)
    State initial_state = {0, 0, 0, 0};
    enqueue(q, initial_state);
    dist[0][0][0] = 0;

    int min_steps = INT_MAX;

    while (!isEmpty(q)) {
        State current = dequeue(q);

        // If we reached the target, update overall minimum steps
        if (current.r == R - 1 && current.c == C - 1) {
            min_steps = (min_steps < current.steps) ? min_steps : current.steps;
        }

        // 1. Normal moves (4 directions)
        for (int i = 0; i < 4; i++) {
            int nr = current.r + dr[i];
            int nc = current.c + dc[i];

            // Check bounds and if it's an empty cell
            if (nr >= 0 && nr < R && nc >= 0 && nc < C && grid[nr][nc] == 0) {
                if (current.steps + 1 < dist[nr][nc][current.scrolls_used]) {
                    dist[nr][nc][current.scrolls_used] = current.steps + 1;
                    State next_state = {nr, nc, current.scrolls_used, current.steps + 1};
                    enqueue(q, next_state);
                }
            }
        }

        // 2. Teleport scroll move
        if (current.scrolls_used < K) {
            // Using a scroll costs 1 step and 1 scroll
            int next_scrolls_used = current.scrolls_used + 1;
            int next_steps = current.steps + 1;

            // Teleport to any empty cell (tr, tc)
            for (int tr = 0; tr < R; tr++) {
                for (int tc = 0; tc < C; tc++) {
                    if (grid[tr][tc] == 0) { // Can only teleport to empty cells
                        if (next_steps < dist[tr][tc][next_scrolls_used]) {
                            dist[tr][tc][next_scrolls_used] = next_steps;
                            State next_state = {tr, tc, next_scrolls_used, next_steps};
                            enqueue(q, next_state);
                        }
                    }
                }
            }
        }
    }

    // Free allocated memory
    for (int i = 0; i < R; i++) {
        for (int j = 0; j < C; j++) {
            free(dist[i][j]);
        }
        free(dist[i]);
    }
    free(dist);
    freeQueue(q);

    return (min_steps == INT_MAX) ? -1 : min_steps;
}