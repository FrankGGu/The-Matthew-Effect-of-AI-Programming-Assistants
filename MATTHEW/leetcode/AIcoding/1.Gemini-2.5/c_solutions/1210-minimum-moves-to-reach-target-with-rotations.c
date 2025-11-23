#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int r;
    int c;
    int orient; // 0 for horizontal, 1 for vertical
    int moves;
} State;

typedef struct {
    State* data;
    int front;
    int rear;
    int capacity;
    int size;
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
    if (q->size == q->capacity) return;
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

int minimumMoves(int** grid, int gridSize, int* gridColSize) {
    int n = gridSize;

    bool*** visited = (bool***)malloc(n * sizeof(bool**));
    for (int i = 0; i < n; i++) {
        visited[i] = (bool**)malloc(n * sizeof(bool*));
        for (int j = 0; j < n; j++) {
            visited[i][j] = (bool*)malloc(2 * sizeof(bool));
            memset(visited[i][j], 0, 2 * sizeof(bool));
        }
    }

    Queue* q = createQueue(n * n * 2);

    State initial_state = {0, 0, 0, 0};
    enqueue(q, initial_state);
    visited[0][0][0] = true;

    while (!isEmpty(q)) {
        State current = dequeue(q);

        if (current.r == n - 1 && current.c == n - 2 && current.orient == 0) {
            int result = current.moves;
            freeQueue(q);
            for (int i = 0; i < n; i++) {
                for (int j = 0; j < n; j++) {
                    free(visited[i][j]);
                }
                free(visited[i]);
            }
            free(visited);
            return result;
        }

        // Move Right
        if (current.orient == 0) { // Horizontal: (r, c), (r, c+1)
            if (current.c + 2 < n && grid[current.r][current.c + 2] == 0) {
                if (!visited[current.r][current.c + 1][0]) {
                    State next = {current.r, current.c + 1, 0, current.moves + 1};
                    enqueue(q, next);
                    visited[current.r][current.c + 1][0] = true;
                }
            }
        } else { // Vertical: (r, c), (r+1, c)
            if (current.c + 1 < n && grid[current.r][current.c + 1] == 0 && grid[current.r + 1][current.c + 1] == 0) {
                if (!visited[current.r][current.c + 1][1]) {
                    State next = {current.r, current.c + 1, 1, current.moves + 1};
                    enqueue(q, next);
                    visited[current.r][current.c + 1][1] = true;
                }
            }
        }

        // Move Down
        if (current.orient == 0) { // Horizontal: (r, c), (r, c+1)
            if (current.r + 1 < n && grid[current.r + 1][current.c] == 0 && grid[current.r + 1][current.c + 1] == 0) {
                if (!visited[current.r + 1][current.c][0]) {
                    State next = {current.r + 1, current.c, 0, current.moves + 1};
                    enqueue(q, next);
                    visited[current.r + 1][current.c][0] = true;
                }
            }
        } else { // Vertical: (r, c), (r+1, c)
            if (current.r + 2 < n && grid[current.r + 2][current.c] == 0) {
                if (!visited[current.r + 1][current.c][1]) {
                    State next = {current.r + 1, current.c, 1, current.moves + 1};
                    enqueue(q, next);
                    visited[current.r + 1][current.c][1] = true;
                }
            }
        }

        // Rotate Clockwise (Horizontal to Vertical)
        if (current.orient == 0) { // Current: (r, c), (r, c+1)
            if (current.r + 1 < n && current.c + 1 < n &&
                grid[current.r + 1][current.c] == 0 && grid[current.r + 1][current.c + 1] == 0) {
                if (!visited[current.r][current.c][1]) {
                    State next = {current.r, current.c, 1, current.moves + 1};
                    enqueue(q, next);
                    visited[current.r][current.c][1] = true;
                }
            }
        }

        // Rotate Counter-Clockwise (Vertical to Horizontal)
        if (current.orient == 1) { // Current: (r, c), (r+1, c)
            if (current.r + 1 < n && current.c + 1 < n &&
                grid[current.r][current.c + 1] == 0 && grid[current.r + 1][current.c + 1] == 0) {
                if (!visited[current.r][current.c][0]) {
                    State next = {current.r, current.c, 0, current.moves + 1};
                    enqueue(q, next);
                    visited[current.r][current.c][0] = true;
                }
            }
        }
    }

    freeQueue(q);
    for (int i = 0; i < n; i++) {
        for (int j = 0; j < n; j++) {
            free(visited[i][j]);
        }
        free(visited[i]);
    }
    free(visited);
    return -1;
}