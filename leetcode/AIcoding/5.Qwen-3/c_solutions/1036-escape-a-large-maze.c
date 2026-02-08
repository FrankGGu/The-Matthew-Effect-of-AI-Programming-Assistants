#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX_SIZE 10000

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point* data;
    int capacity;
    int size;
} Queue;

Queue* create_queue() {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (Point*)malloc(MAX_SIZE * sizeof(Point));
    q->capacity = MAX_SIZE;
    q->size = 0;
    return q;
}

void enqueue(Queue* q, Point p) {
    if (q->size < q->capacity) {
        q->data[q->size++] = p;
    }
}

bool dequeue(Queue* q, Point* p) {
    if (q->size > 0) {
        *p = q->data[0];
        for (int i = 1; i < q->size; i++) {
            q->data[i - 1] = q->data[i];
        }
        q->size--;
        return true;
    }
    return false;
}

void free_queue(Queue* q) {
    free(q->data);
    free(q);
}

bool is_escape_possible(int** target, int targetSize, int** blocked, int blockedSize, int* blockSize) {
    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int max_steps = 2 * (blockedSize + 1);
    int visited[MAX_SIZE][MAX_SIZE] = {0};
    int start_x = 0, start_y = 0;
    int target_x = target[0][0], target_y = target[0][1];

    Queue* q = create_queue();
    Point start = {start_x, start_y};
    enqueue(q, start);
    visited[start_x][start_y] = 1;

    while (q->size > 0 && max_steps > 0) {
        Point current;
        dequeue(q, &current);
        max_steps--;

        for (int i = 0; i < 4; i++) {
            int nx = current.x + dirs[i][0];
            int ny = current.y + dirs[i][1];

            if (nx >= 0 && nx < MAX_SIZE && ny >= 0 && ny < MAX_SIZE && !visited[nx][ny]) {
                bool is_blocked = false;
                for (int j = 0; j < blockedSize; j++) {
                    if (nx == blocked[j][0] && ny == blocked[j][1]) {
                        is_blocked = true;
                        break;
                    }
                }

                if (!is_blocked) {
                    visited[nx][ny] = 1;
                    Point next = {nx, ny};
                    enqueue(q, next);

                    if (nx == target_x && ny == target_y) {
                        free_queue(q);
                        return true;
                    }
                }
            }
        }
    }

    free_queue(q);
    return false;
}