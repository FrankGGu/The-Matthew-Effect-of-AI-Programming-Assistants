#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

typedef struct {
    int time;
    int r;
    int c;
} PQNode;

PQNode* heap;
int heapCapacity;
int heapSize;

void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(int index) {
    while (index > 0 && heap[index].time < heap[(index - 1) / 2].time) {
        swap(&heap[index], &heap[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

void heapifyDown(int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heapSize && heap[left].time < heap[smallest].time) {
        smallest = left;
    }
    if (right < heapSize && heap[right].time < heap[smallest].time) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap[index], &heap[smallest]);
        heapifyDown(smallest);
    }
}

void push(PQNode node) {
    heap[heapSize++] = node;
    heapifyUp(heapSize - 1);
}

PQNode pop() {
    PQNode root = heap[0];
    heap[0] = heap[--heapSize];
    heapifyDown(0);
    return root;
}

bool isEmpty() {
    return heapSize == 0;
}

int swimInRisingWater(int** grid, int gridSize, int* gridColSize) {
    int N = gridSize;

    // Allocate and initialize distance array
    int** dist = (int**)malloc(N * sizeof(int*));
    for (int i = 0; i < N; i++) {
        dist[i] = (int*)malloc(N * sizeof(int));
        for (int j = 0; j < N; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    // Initialize heap
    heapCapacity = N * N;
    heap = (PQNode*)malloc(heapCapacity * sizeof(PQNode));
    heapSize = 0;

    // Dijkstra's algorithm start
    dist[0][0] = grid[0][0];
    push((PQNode){grid[0][0], 0, 0});

    while (!isEmpty()) {
        PQNode current = pop();
        int t = current.time;
        int r = current.r;
        int c = current.c;

        // If we already found a better path to (r,c), skip
        if (t > dist[r][c]) {
            continue;
        }

        // If we reached the destination, this is the minimum time
        if (r == N - 1 && c == N - 1) {
            // Free allocated memory
            for (int i = 0; i < N; i++) {
                free(dist[i]);
            }
            free(dist);
            free(heap);
            return t;
        }

        // Explore neighbors
        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check bounds
            if (nr >= 0 && nr < N && nc >= 0 && nc < N) {
                // The time to reach (nr, nc) is the maximum of current path time
                // and the elevation of the new cell
                int newTime = (t > grid[nr][nc]) ? t : grid[nr][nc];

                if (newTime < dist[nr][nc]) {
                    dist[nr][nc] = newTime;
                    push((PQNode){newTime, nr, nc});
                }
            }
        }
    }

    // Should not be reached for valid inputs as a path always exists
    // Free allocated memory in case of unexpected exit
    for (int i = 0; i < N; i++) {
        free(dist[i]);
    }
    free(dist);
    free(heap);
    return -1; // Indicate error or no path found
}