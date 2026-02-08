#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
} Position;

typedef struct {
    Position* data;
    int front;
    int rear;
    int size;
    int capacity;
} Queue;

Queue* createQueue(int capacity) {
    Queue* q = (Queue*)malloc(sizeof(Queue));
    q->data = (Position*)malloc(capacity * sizeof(Position));
    q->front = 0;
    q->rear = -1;
    q->size = 0;
    q->capacity = capacity;
    return q;
}

void enqueue(Queue* q, Position pos) {
    if (q->size == q->capacity) return;
    q->rear = (q->rear + 1) % q->capacity;
    q->data[q->rear] = pos;
    q->size++;
}

Position dequeue(Queue* q) {
    Position pos = q->data[q->front];
    q->front = (q->front + 1) % q->capacity;
    q->size--;
    return pos;
}

int isEmpty(Queue* q) {
    return q->size == 0;
}

void freeQueue(Queue* q) {
    free(q->data);
    free(q);
}

int** buildGrid(int** grid, int gridSize, int* gridColSize) {
    int** result = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        result[i] = (int*)malloc(*gridColSize * sizeof(int));
        for (int j = 0; j < *gridColSize; j++) {
            result[i][j] = grid[i][j];
        }
    }
    return result;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int bfs(int** grid, int gridSize, int* gridColSize, int startRow, int startCol, int time) {
    int** dist = (int**)malloc(gridSize * sizeof(int*));
    for (int i = 0; i < gridSize; i++) {
        dist[i] = (int*)malloc(*gridColSize * sizeof(int));
        for (int j = 0; j < *gridColSize; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    Queue* q = createQueue(gridSize * *gridColSize);
    Position start = {startRow, startCol};
    dist[startRow][startCol] = 0;
    enqueue(q, start);

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (!isEmpty(q)) {
        Position current = dequeue(q);
        int r = current.row;
        int c = current.col;

        for (int i = 0; i < 4; i++) {
            int nr = r + directions[i][0];
            int nc = c + directions[i][1];

            if (nr >= 0 && nr < gridSize && nc >= 0 && nc < *gridColSize && grid[nr][nc] == 0 && dist[nr][nc] == INT_MAX) {
                dist[nr][nc] = dist[r][c] + 1;
                enqueue(q, (Position){nr, nc});
            }
        }
    }

    int maxTime = 0;
    for (int i = 0; i < gridSize; i++) {
        for (int j = 0; j < *gridColSize; j++) {
            if (grid[i][j] == 0 && dist[i][j] != INT_MAX) {
                maxTime = max(maxTime, dist[i][j]);
            }
        }
    }

    for (int i = 0; i < gridSize; i++) {
        free(dist[i]);
    }
    free(dist);
    freeQueue(q);
    return maxTime;
}

int maximumMinutes(int** grid, int gridSize, int* gridColSize) {
    int rows = gridSize;
    int cols = *gridColSize;

    int** fireGrid = buildGrid(grid, gridSize, gridColSize);
    int** personGrid = buildGrid(grid, gridSize, gridColSize);

    int fireTime[rows][cols];
    int personTime[rows][cols];

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            fireTime[i][j] = INT_MAX;
            personTime[i][j] = INT_MAX;
        }
    }

    Queue* fireQ = createQueue(rows * cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 1) {
                fireTime[i][j] = 0;
                enqueue(fireQ, (Position){i, j});
            }
        }
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    while (!isEmpty(fireQ)) {
        Position current = dequeue(fireQ);
        int r = current.row;
        int c = current.col;

        for (int i = 0; i < 4; i++) {
            int nr = r + directions[i][0];
            int nc = c + directions[i][1];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols && fireTime[nr][nc] == INT_MAX) {
                fireTime[nr][nc] = fireTime[r][c] + 1;
                enqueue(fireQ, (Position){nr, nc});
            }
        }
    }

    freeQueue(fireQ);

    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (grid[i][j] == 0) {
                personTime[i][j] = bfs(grid, rows, gridColSize, i, j, 0);
            }
        }
    }

    int left = 0;
    int right = 1e9;
    int answer = -1;

    while (left <= right) {
        int mid = (left + right) / 2;
        int canEscape = 1;

        for (int i = 0; i < rows; i++) {
            for (int j = 0; j < cols; j++) {
                if (grid[i][j] == 0) {
                    if (personTime[i][j] < mid) {
                        canEscape = 0;
                        break;
                    } else if (personTime[i][j] == mid) {
                        if (fireTime[i][j] <= mid) {
                            canEscape = 0;
                            break;
                        }
                    }
                }
            }
            if (!canEscape) break;
        }

        if (canEscape) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    for (int i = 0; i < rows; i++) {
        free(fireGrid[i]);
        free(personGrid[i]);
    }
    free(fireGrid);
    free(personGrid);

    return answer;
}