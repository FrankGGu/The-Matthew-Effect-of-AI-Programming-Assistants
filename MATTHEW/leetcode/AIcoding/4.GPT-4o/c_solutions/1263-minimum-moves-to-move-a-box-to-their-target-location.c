#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX 1000

typedef struct {
    int x, y;
} Point;

typedef struct {
    Point box;
    Point target;
    int moves;
} State;

typedef struct {
    State states[MAX];
    int front, rear;
} Queue;

void initQueue(Queue *q) {
    q->front = 0;
    q->rear = 0;
}

bool isEmpty(Queue *q) {
    return q->front == q->rear;
}

void enqueue(Queue *q, State state) {
    q->states[q->rear++] = state;
}

State dequeue(Queue *q) {
    return q->states[q->front++];
}

bool isVisited[MAX][MAX][MAX][MAX];

int minMoves(char **grid, int gridSize, int *gridColSize, int *box, int *target) {
    int rows = gridSize;
    int cols = *gridColSize;
    Point directions[4] = {{1, 0}, {-1, 0}, {0, 1}, {0, -1}};

    Queue queue;
    initQueue(&queue);

    State start = {{box[0], box[1]}, {target[0], target[1]}, 0};
    enqueue(&queue, start);
    isVisited[box[0]][box[1]][target[0]][target[1]] = true;

    while (!isEmpty(&queue)) {
        State current = dequeue(&queue);

        if (current.box.x == current.target.x && current.box.y == current.target.y) {
            return current.moves;
        }

        for (int i = 0; i < 4; i++) {
            int newBoxX = current.box.x + directions[i].x;
            int newBoxY = current.box.y + directions[i].y;
            int newTargetX = current.box.x - directions[i].x;
            int newTargetY = current.box.y - directions[i].y;

            if (newBoxX >= 0 && newBoxX < rows && newBoxY >= 0 && newBoxY < cols &&
                grid[newBoxX][newBoxY] != '#' && 
                newTargetX >= 0 && newTargetX < rows && newTargetY >= 0 && newTargetY < cols &&
                grid[newTargetX][newTargetY] != '#' && 
                !isVisited[newBoxX][newBoxY][current.box.x][current.box.y]) {

                State next = {{newBoxX, newBoxY}, {current.target.x, current.target.y}, current.moves + 1};
                enqueue(&queue, next);
                isVisited[newBoxX][newBoxY][current.box.x][current.box.y] = true;
            }
        }
    }

    return -1;
}