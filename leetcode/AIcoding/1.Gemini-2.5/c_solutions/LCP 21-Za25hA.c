#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

typedef struct {
    int rA, cA;
    int rB, cB;
    int time;
} State;

typedef struct {
    State* data;
    int front;
    int rear;
    int capacity;
} Queue;

void initQueue(Queue* q, int capacity) {
    q->data = (State*)malloc(sizeof(State) * capacity);
    q->front = 0;
    q->rear = -1;
    q->capacity = capacity;
}

bool isEmpty(Queue* q) {
    return q->front > q->rear;
}

void enqueue(Queue* q, State s) {
    q->data[++q->rear] = s;
}

State dequeue(Queue* q) {
    return q->data[q->front++];
}

void freeQueue(Queue* q) {
    free(q->data);
}

bool isValid(int r, int c, int M_rows, int N_cols, int** grid) {
    return r >= 0 && r < M_rows && c >= 0 && c < N_cols && grid[r][c] == 0;
}

int chaseGame(int** grid, int* startA, int* startB, int M_rows, int N_cols) {
    if (startA[0] == startB[0] && startA[1] == startB[1]) {
        return 0;
    }

    bool**** visited = (bool****)malloc(M_rows * sizeof(bool***));
    for (int i = 0; i < M_rows; ++i) {
        visited[i] = (bool***)malloc(N_cols * sizeof(bool**));
        for (int j = 0; j < N_cols; ++j) {
            visited[i][j] = (bool**)malloc(M_rows * sizeof(bool*));
            for (int k = 0; k < M_rows; ++k) {
                visited[i][j][k] = (bool*)malloc(N_cols * sizeof(bool));
                memset(visited[i][j][k], 0, N_cols * sizeof(bool));
            }
        }
    }

    Queue q;
    initQueue(&q, M_rows * N_cols * M_rows * N_cols + 100);

    State initialState = {startA[0], startA[1], startB[0], startB[1], 0};
    enqueue(&q, initialState);
    visited[startA[0]][startA[1]][startB[0]][startB[1]] = true;

    while (!isEmpty(&q)) {
        State current = dequeue(&q);

        for (int i = 0; i < 4; ++i) {
            int nrA = current.rA + dr[i];
            int ncA = current.cA + dc[i];

            if (!isValid(nrA, ncA, M_rows, N_cols, grid)) {
                continue;
            }

            for (int j = 0; j < 4; ++j) {
                int nrB = current.rB + dr[j];
                int ncB = current.cB + dc[j];

                if (!isValid(nrB, ncB, M_rows, N_cols, grid)) {
                    continue;
                }

                if (nrA == nrB && ncA == ncB) {
                    int result = current.time + 1;
                    for (int r1 = 0; r1 < M_rows; ++r1) {
                        for (int c1 = 0; c1 < N_cols; ++c1) {
                            for (int r2 = 0; r2 < M_rows; ++r2) {
                                free(visited[r1][c1][r2]);
                            }
                            free(visited[r1][c1]);
                        }
                        free(visited[r1]);
                    }
                    free(visited);
                    freeQueue(&q);
                    return result;
                }

                if (!visited[nrA][ncA][nrB][ncB]) {
                    visited[nrA][ncA][nrB][ncB] = true;
                    State nextState = {nrA, ncA, nrB, ncB, current.time + 1};
                    enqueue(&q, nextState);
                }
            }
        }
    }

    for (int r1 = 0; r1 < M_rows; ++r1) {
        for (int c1 = 0; c1 < N_cols; ++c1) {
            for (int r2 = 0; r2 < M_rows; ++r2) {
                free(visited[r1][c1][r2]);
            }
            free(visited[r1][c1]);
        }
        free(visited[r1]);
    }
    free(visited);
    freeQueue(&q);

    return -1;
}