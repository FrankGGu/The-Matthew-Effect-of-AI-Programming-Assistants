#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
    int k;
} State;

typedef struct {
    State* data;
    int size;
    int capacity;
} Queue;

Queue* create_queue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->size = 0;
    q->capacity = 1;
    q->data = (State*)malloc(q->capacity * sizeof(State));
    return q;
}

void enqueue(Queue* q, State s) {
    if (q->size == q->capacity) {
        q->capacity *= 2;
        q->data = (State*)realloc(q->data, q->capacity * sizeof(State));
    }
    q->data[q->size++] = s;
}

State dequeue(Queue* q) {
    return q->data[--q->size];
}

int is_empty(Queue* q) {
    return q->size == 0;
}

void free_queue(Queue* q) {
    free(q->data);
    free(q);
}

int shortestPath(int** grid, int gridSize, int* gridColSize, int k) {
    int rows = gridSize;
    int cols = gridColSize[0];
    int** visited = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = -1;
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    Queue* q = create_queue();
    State start = {0, 0, k};
    enqueue(q, start);
    visited[0][0] = k;

    int steps = 0;
    while (!is_empty(q)) {
        int level_size = q->size;
        for (int i = 0; i < level_size; i++) {
            State current = dequeue(q);
            if (current.x == rows - 1 && current.y == cols - 1) {
                free_queue(q);
                for (int i = 0; i < rows; i++) free(visited[i]);
                free(visited);
                return steps;
            }
            for (int d = 0; d < 4; d++) {
                int nx = current.x + directions[d][0];
                int ny = current.y + directions[d][1];
                if (nx >= 0 && nx < rows && ny >= 0 && ny < cols) {
                    int new_k = current.k;
                    if (grid[nx][ny] == 1) {
                        new_k--;
                    }
                    if (new_k >= 0 && (visited[nx][ny] < new_k)) {
                        visited[nx][ny] = new_k;
                        State next = {nx, ny, new_k};
                        enqueue(q, next);
                    }
                }
            }
        }
        steps++;
    }

    free_queue(q);
    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    return -1;
}