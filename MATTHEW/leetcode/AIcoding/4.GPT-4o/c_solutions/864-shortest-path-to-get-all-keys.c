#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MAX_QUEUE_SIZE 10000
#define MAX_MASK 64

typedef struct {
    int x, y, keys;
} State;

typedef struct {
    State states[MAX_QUEUE_SIZE];
    int front, rear;
} Queue;

void initQueue(Queue* q) {
    q->front = 0;
    q->rear = 0;
}

void enqueue(Queue* q, State s) {
    q->states[q->rear++] = s;
}

State dequeue(Queue* q) {
    return q->states[q->front++];
}

int isEmpty(Queue* q) {
    return q->front == q->rear;
}

int shortestPathAllKeys(char** grid, int gridSize, int* gridColSize) {
    int startX, startY, totalKeys = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < (*gridColSize); j++) {
            if (grid[i][j] == '@') {
                startX = i;
                startY = j;
            }
            if (grid[i][j] >= 'a' && grid[i][j] <= 'f') {
                totalKeys++;
            }
        }
    }

    Queue q;
    initQueue(&q);
    int visited[gridSize][*gridColSize][1 << totalKeys];
    memset(visited, 0, sizeof(visited));

    enqueue(&q, (State){startX, startY, 0});
    visited[startX][startY][0] = 1;

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int steps = 0;

    while (!isEmpty(&q)) {
        int size = q.rear - q.front;
        for (int i = 0; i < size; i++) {
            State current = dequeue(&q);
            if (current.keys == (1 << totalKeys) - 1) {
                return steps;
            }
            for (int d = 0; d < 4; d++) {
                int nx = current.x + directions[d][0];
                int ny = current.y + directions[d][1];
                if (nx < 0 || ny < 0 || nx >= gridSize || ny >= *gridColSize) continue;
                char cell = grid[nx][ny];
                if (cell == '#') continue;
                int nextKeys = current.keys;
                if (cell >= 'a' && cell <= 'f') {
                    nextKeys |= 1 << (cell - 'a');
                } else if (cell >= 'A' && cell <= 'F') {
                    if (!(current.keys & (1 << (cell - 'A')))) continue;
                }
                if (!visited[nx][ny][nextKeys]) {
                    visited[nx][ny][nextKeys] = 1;
                    enqueue(&q, (State){nx, ny, nextKeys});
                }
            }
        }
        steps++;
    }
    return -1;
}