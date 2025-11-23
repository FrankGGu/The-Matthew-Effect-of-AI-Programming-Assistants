#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char *state;
    int moves;
} Node;

typedef struct {
    char *data;
    int size;
} Queue;

void enqueue(Queue *q, char *state, int moves) {
    q->data = realloc(q->data, (q->size + 1) * sizeof(char *));
    q->data[q->size++] = strdup(state);
}

char *dequeue(Queue *q) {
    char *front = q->data[0];
    memmove(q->data, q->data + 1, (q->size - 1) * sizeof(char *));
    q->size--;
    return front;
}

int isVisited(char **visited, int visitedSize, char *state) {
    for (int i = 0; i < visitedSize; i++) {
        if (strcmp(visited[i], state) == 0) {
            return 1;
        }
    }
    return 0;
}

void addVisited(char ***visited, int *visitedSize, char *state) {
    *visited = realloc(*visited, (*visitedSize + 1) * sizeof(char *));
    (*visited)[*visitedSize] = strdup(state);
    (*visitedSize)++;
}

char *swap(char *s, int i, int j) {
    char *newState = strdup(s);
    char temp = newState[i];
    newState[i] = newState[j];
    newState[j] = temp;
    return newState;
}

int slidingPuzzle(int* board, int boardSize, int* boardColSize) {
    char initial[6];
    for (int i = 0; i < 6; i++) {
        initial[i] = '0' + board[i];
    }
    initial[6] = '\0';

    char target[] = "123450";

    Queue q;
    q.data = NULL;
    q.size = 0;

    enqueue(&q, initial, 0);

    char **visited = NULL;
    int visitedSize = 0;

    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};

    while (q.size > 0) {
        char *current = dequeue(&q);
        int moves = 0;

        for (int i = 0; i < 6; i++) {
            if (current[i] == '0') {
                int row = i / 3;
                int col = i % 3;

                for (int d = 0; d < 4; d++) {
                    int newRow = row + directions[d][0];
                    int newCol = col + directions[d][1];

                    if (newRow >= 0 && newRow < 2 && newCol >= 0 && newCol < 3) {
                        int newIndex = newRow * 3 + newCol;
                        char *nextState = swap(current, i, newIndex);

                        if (strcmp(nextState, target) == 0) {
                            free(current);
                            free(nextState);
                            return moves + 1;
                        }

                        if (!isVisited(visited, visitedSize, nextState)) {
                            addVisited(&visited, &visitedSize, nextState);
                            enqueue(&q, nextState, moves + 1);
                        }

                        free(nextState);
                    }
                }
            }
        }

        free(current);
    }

    return -1;
}