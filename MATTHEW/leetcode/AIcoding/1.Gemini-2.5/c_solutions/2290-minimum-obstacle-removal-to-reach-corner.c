#include <stdlib.h>
#include <limits.h>
#include <stdbool.h>

typedef struct {
    int r, c;
} Cell;

typedef struct {
    Cell* arr;
    int front, rear;
    int capacity;
    int size;
} Deque;

Deque* createDeque(int capacity) {
    Deque* dq = (Deque*)malloc(sizeof(Deque));
    dq->arr = (Cell*)malloc(sizeof(Cell) * capacity);
    dq->front = 0;
    dq->rear = -1;
    dq->capacity = capacity;
    dq->size = 0;
    return dq;
}

void push_front(Deque* dq, Cell cell) {
    if (dq->size == dq->capacity) {
        return;
    }
    dq->front = (dq->front - 1 + dq->capacity) % dq->capacity;
    dq->arr[dq->front] = cell;
    dq->size++;
}

void push_back(Deque* dq, Cell cell) {
    if (dq->size == dq->capacity) {
        return;
    }
    dq->rear = (dq->rear + 1) % dq->capacity;
    dq->arr[dq->rear] = cell;
    dq->size++;
}

Cell pop_front(Deque* dq) {
    Cell cell = dq->arr[dq->front];
    dq->front = (dq->front + 1) % dq->capacity;
    dq->size--;
    return cell;
}

bool isEmpty(Deque* dq) {
    return dq->size == 0;
}

void freeDeque(Deque* dq) {
    free(dq->arr);
    free(dq);
}

int minimumObstacles(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    int** dist = (int**)malloc(sizeof(int*) * m);
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(sizeof(int) * n);
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    Deque* dq = createDeque(m * n);

    dist[0][0] = 0;
    push_front(dq, (Cell){0, 0});

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (!isEmpty(dq)) {
        Cell current = pop_front(dq);
        int r = current.r;
        int c = current.c;

        if (r == m - 1 && c == n - 1) {
            // Optimization: If target reached, we can return early
            // as 0-1 BFS explores in non-decreasing order of cost.
            // However, the loop will naturally terminate and return the correct value.
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int new_cost = dist[r][c] + grid[nr][nc];
                if (new_cost < dist[nr][nc]) {
                    dist[nr][nc] = new_cost;
                    if (grid[nr][nc] == 0) { // No obstacle, push to front
                        push_front(dq, (Cell){nr, nc});
                    } else { // Obstacle, push to back
                        push_back(dq, (Cell){nr, nc});
                    }
                }
            }
        }
    }

    int result = dist[m - 1][n - 1];

    freeDeque(dq);
    for (int i = 0; i < m; i++) {
        free(dist[i]);
    }
    free(dist);

    return result;
}