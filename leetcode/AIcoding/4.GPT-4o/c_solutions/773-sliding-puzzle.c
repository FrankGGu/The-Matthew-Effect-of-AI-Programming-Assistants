#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char board[2][3];
    int zero_row, zero_col, steps;
} State;

typedef struct {
    State *states;
    int front, rear, size, capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* queue = (Queue*)malloc(sizeof(Queue));
    queue->capacity = capacity;
    queue->front = queue->size = 0;
    queue->rear = capacity - 1;
    queue->states = (State*)malloc(capacity * sizeof(State));
    return queue;
}

int isFull(Queue* queue) {
    return (queue->size == queue->capacity);
}

int isEmpty(Queue* queue) {
    return (queue->size == 0);
}

void enqueue(Queue* queue, State state) {
    if (!isFull(queue)) {
        queue->rear = (queue->rear + 1) % queue->capacity;
        queue->states[queue->rear] = state;
        queue->size++;
    }
}

State dequeue(Queue* queue) {
    State state = queue->states[queue->front];
    if (!isEmpty(queue)) {
        queue->front = (queue->front + 1) % queue->capacity;
        queue->size--;
    }
    return state;
}

int isVisited[1000000];

int hashBoard(char board[2][3]) {
    int hash = 0;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            hash = hash * 10 + (board[i][j] - '0');
        }
    }
    return hash;
}

int slidingPuzzle(int** board, int boardSize, int* boardColSize) {
    char target[2][3] = {{'1', '2', '3'}, {'4', '5', '0'}};
    char initial[2][3] = {{(char)(board[0][0] + '0'), (char)(board[0][1] + '0'), (char)(board[0][2] + '0')},
                          {(char)(board[1][0] + '0'), (char)(board[1][1] + '0'), (char)(board[1][2] + '0')}};

    int zero_row, zero_col;
    for (int i = 0; i < 2; i++) {
        for (int j = 0; j < 3; j++) {
            if (initial[i][j] == '0') {
                zero_row = i;
                zero_col = j;
            }
        }
    }

    Queue* queue = createQueue(10000);
    State start = {.steps = 0, .zero_row = zero_row, .zero_col = zero_col};
    memcpy(start.board, initial, sizeof(start.board));
    enqueue(queue, start);
    isVisited[hashBoard(initial)] = 1;

    int directions[4][2] = {{1, 0}, {0, 1}, {-1, 0}, {0, -1}};
    while (!isEmpty(queue)) {
        State current = dequeue(queue);
        if (memcmp(current.board, target, sizeof(target)) == 0) {
            return current.steps;
        }
        for (int i = 0; i < 4; i++) {
            int new_row = current.zero_row + directions[i][0];
            int new_col = current.zero_col + directions[i][1];
            if (new_row >= 0 && new_row < 2 && new_col >= 0 && new_col < 3) {
                State next = current;
                next.board[current.zero_row][current.zero_col] = current.board[new_row][new_col];
                next.board[new_row][new_col] = '0';
                next.zero_row = new_row;
                next.zero_col = new_col;
                next.steps++;
                int hash = hashBoard(next.board);
                if (!isVisited[hash]) {
                    isVisited[hash] = 1;
                    enqueue(queue, next);
                }
            }
        }
    }
    return -1;
}