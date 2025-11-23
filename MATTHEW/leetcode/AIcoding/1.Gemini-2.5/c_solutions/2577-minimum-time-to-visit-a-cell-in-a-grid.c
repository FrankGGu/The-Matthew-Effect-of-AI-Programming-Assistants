#include <stdlib.h>
#include <stdbool.h>
#include <limits.h> // For LLONG_MAX

typedef struct {
    long long time;
    int r, c;
} PQNode;

typedef struct {
    PQNode* heap;
    int capacity;
    int size;
} PriorityQueue;

void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(PriorityQueue* pq, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && pq->heap[index].time < pq->heap[parent].time) {
        swap(&pq->heap[index], &pq->heap[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(PriorityQueue* pq, int index) {
    int leftChild, rightChild, smallest;
    while (true) {
        leftChild = 2 * index + 1;
        rightChild = 2 * index + 2;
        smallest = index;

        if (leftChild < pq->size && pq->heap[leftChild].time < pq->heap[smallest].time) {
            smallest = leftChild;
        }
        if (rightChild < pq->size && pq->heap[rightChild].time < pq->heap[smallest].time) {
            smallest = rightChild;
        }

        if (smallest != index) {
            swap(&pq->heap[index], &pq->heap[smallest]);
            index = smallest;
        } else {
            break;
        }
    }
}

PriorityQueue* createPriorityQueue(int capacity) {
    PriorityQueue* pq = (PriorityQueue*)malloc(sizeof(PriorityQueue));
    pq->heap = (PQNode*)malloc(sizeof(PQNode) * capacity);
    pq->capacity = capacity;
    pq->size = 0;
    return pq;
}

bool isEmpty(PriorityQueue* pq) {
    return pq->size == 0;
}

void push(PriorityQueue* pq, long long time, int r, int c) {
    if (pq->size == pq->capacity) {
        pq->capacity *= 2;
        pq->heap = (PQNode*)realloc(pq->heap, sizeof(PQNode) * pq->capacity);
    }
    pq->heap[pq->size].time = time;
    pq->heap[pq->size].r = r;
    pq->heap[pq->size].c = c;
    heapifyUp(pq, pq->size);
    pq->size++;
}

PQNode pop(PriorityQueue* pq) {
    PQNode node = pq->heap[0];
    pq->heap[0] = pq->heap[pq->size - 1];
    pq->size--;
    heapifyDown(pq, 0);
    return node;
}

void freePriorityQueue(PriorityQueue* pq) {
    free(pq->heap);
    free(pq);
}

int minimumTime(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    // Special condition: If both adjacent cells to (0,0) require time > 0, it's impossible.
    // This applies only if the grid is at least 2x2.
    if (m > 1 && n > 1 && grid[0][1] > 0 && grid[1][0] > 0) {
        return -1;
    }

    // Dijkstra's algorithm
    long long** dist = (long long**)malloc(m * sizeof(long long*));
    for (int i = 0; i < m; ++i) {
        dist[i] = (long long*)malloc(n * sizeof(long long));
        for (int j = 0; j < n; ++j) {
            dist[i][j] = LLONG_MAX;
        }
    }

    PriorityQueue* pq = createPriorityQueue(m * n);

    dist[0][0] = 0;
    push(pq, 0, 0, 0);

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    while (!isEmpty(pq)) {
        PQNode current = pop(pq);
        long long t = current.time;
        int r = current.r;
        int c = current.c;

        if (t > dist[r][c]) {
            continue;
        }
        if (r == m - 1 && c == n - 1) {
            long long result = dist[m-1][n-1];
            for (int i = 0; i < m; ++i) {
                free(dist[i]);
            }
            free(dist);
            freePriorityQueue(pq);
            return (int)result;
        }

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                long long arrival_time = t + 1;

                // If the direct arrival time is less than the required time for the cell,
                // we must wait at the current cell (r,c) until grid[nr][nc]-1, then move.
                // This means we arrive at (nr,nc) at time grid[nr][nc].
                if (arrival_time < grid[nr][nc]) {
                    arrival_time = grid[nr][nc];
                }

                // Parity adjustment:
                // We start at (0,0) at time 0. (0+0)%2 == 0%2. The parity (time % 2 == (r+c) % 2) is consistent.
                // We need to maintain this consistency.
                // When moving from (r,c) to (nr,nc), (r+c) and (nr+nc) have different parities.
                // If the calculated arrival_time has a different parity than (nr+nc),
                // we must wait an additional 1 unit of time to correct the parity.
                if ((arrival_time % 2) != ((nr + nc) % 2)) {
                    arrival_time++;
                }

                if (arrival_time < dist[nr][nc]) {
                    dist[nr][nc] = arrival_time;
                    push(pq, arrival_time, nr, nc);
                }
            }
        }
    }

    for (int i = 0; i < m; ++i) {
        free(dist[i]);
    }
    free(dist);
    freePriorityQueue(pq);
    return -1; // Target is unreachable
}