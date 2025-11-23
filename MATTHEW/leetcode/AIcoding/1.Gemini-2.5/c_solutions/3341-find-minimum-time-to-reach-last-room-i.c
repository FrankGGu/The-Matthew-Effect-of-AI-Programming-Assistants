#include <limits.h> // For LLONG_MAX
#include <stdlib.h> // For malloc, free

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

typedef struct {
    long long time;
    int r;
    int c;
} PQNode;

PQNode* heap;
int heap_size;
int heap_capacity;

void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

void heap_push(PQNode node) {
    if (heap_size == heap_capacity) {
        heap_capacity *= 2; // Double capacity
        heap = (PQNode*)realloc(heap, heap_capacity * sizeof(PQNode));
    }
    heap[heap_size] = node;
    int current = heap_size;
    while (current > 0 && heap[current].time < heap[(current - 1) / 2].time) {
        swap(&heap[current], &heap[(current - 1) / 2]);
        current = (current - 1) / 2;
    }
    heap_size++;
}

PQNode heap_pop() {
    PQNode min_node = heap[0];
    heap[0] = heap[heap_size - 1];
    heap_size--;
    int current = 0;
    while (1) {
        int left_child = 2 * current + 1;
        int right_child = 2 * current + 2;
        int smallest = current;

        if (left_child < heap_size && heap[left_child].time < heap[smallest].time) {
            smallest = left_child;
        }
        if (right_child < heap_size && heap[right_child].time < heap[smallest].time) {
            smallest = right_child;
        }

        if (smallest != current) {
            swap(&heap[current], &heap[smallest]);
            current = smallest;
        } else {
            break;
        }
    }
    return min_node;
}

long long minimumTime(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 1 && n == 1) {
        return 0;
    }

    long long** dist = (long long**)malloc(m * sizeof(long long*));
    for (int i = 0; i < m; i++) {
        dist[i] = (long long*)malloc(n * sizeof(long long));
        for (int j = 0; j < n; j++) {
            dist[i][j] = LLONG_MAX;
        }
    }

    heap_capacity = 4 * m * n; // Max number of edges, provides sufficient initial heap capacity
    heap = (PQNode*)malloc(heap_capacity * sizeof(PQNode));
    heap_size = 0;

    dist[0][0] = 0;
    heap_push((PQNode){0, 0, 0});

    while (heap_size > 0) {
        PQNode current_node = heap_pop();
        long long curr_time = current_node.time;
        int r = current_node.r;
        int c = current_node.c;

        if (curr_time > dist[r][c]) {
            continue;
        }

        if (r == m - 1 && c == n - 1) {
            for (int i = 0; i < m; i++) {
                free(dist[i]);
            }
            free(dist);
            free(heap);
            return curr_time;
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                long long move_time = curr_time + 1;
                long long next_arrival_time = move_time;

                if (next_arrival_time < grid[nr][nc]) {
                    next_arrival_time = grid[nr][nc];
                }

                if (next_arrival_time < dist[nr][nc]) {
                    dist[nr][nc] = next_arrival_time;
                    heap_push((PQNode){next_arrival_time, nr, nc});
                }
            }
        }
    }

    for (int i = 0; i < m; i++) {
        free(dist[i]);
    }
    free(dist);
    free(heap);
    return -1;
}