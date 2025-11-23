#include <stdlib.h> // For malloc, free, abs
#include <limits.h> // For INT_MAX

static int dr[] = {-1, 1, 0, 0};
static int dc[] = {0, 0, -1, 1};

typedef struct {
    int effort;
    int r;
    int c;
} PQNode;

static void swap(PQNode* a, PQNode* b) {
    PQNode temp = *a;
    *a = *b;
    *b = temp;
}

static void heapify_up(PQNode* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap[index].effort < heap[parent].effort) {
        swap(&heap[index], &heap[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

static void heapify_down(PQNode* heap, int heap_size, int index) {
    int left = 2 * index + 1;
    int right = 2 * index + 2;
    int smallest = index;

    if (left < heap_size && heap[left].effort < heap[smallest].effort) {
        smallest = left;
    }
    if (right < heap_size && heap[right].effort < heap[smallest].effort) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap[index], &heap[smallest]);
        heapify_down(heap, heap_size, smallest);
    }
}

static void heap_push(PQNode* heap, int* heap_size_ptr, int heap_capacity, int effort, int r, int c) {
    if (*heap_size_ptr == heap_capacity) {
        return; // Should not happen if capacity is correctly managed
    }
    heap[*heap_size_ptr].effort = effort;
    heap[*heap_size_ptr].r = r;
    heap[*heap_size_ptr].c = c;
    (*heap_size_ptr)++;
    heapify_up(heap, *heap_size_ptr - 1);
}

static PQNode heap_pop(PQNode* heap, int* heap_size_ptr) {
    PQNode min_node = heap[0];
    heap[0] = heap[*heap_size_ptr - 1];
    (*heap_size_ptr)--;
    heapify_down(heap, *heap_size_ptr, 0);
    return min_node;
}

static int heap_is_empty(int heap_size) {
    return heap_size == 0;
}

static int max(int a, int b) {
    return a > b ? a : b;
}

int minimumEffortPath(int** heights, int heightsSize, int* heightsColSize) {
    int rows = heightsSize;
    int cols = heightsColSize[0]; // Assuming a rectangular grid

    // dist[r][c] stores the minimum maximum effort to reach (r,c) from (0,0)
    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX; // Initialize with a very large value
        }
    }

    dist[0][0] = 0; // Effort to reach starting cell is 0

    // Priority queue variables
    int heap_capacity = rows * cols;
    PQNode* heap = (PQNode*)malloc(sizeof(PQNode) * heap_capacity);
    int heap_size = 0;

    // Push the starting cell into the priority queue
    heap_push(heap, &heap_size, heap_capacity, 0, 0, 0);

    while (!heap_is_empty(heap_size)) {
        PQNode current = heap_pop(heap, &heap_size);
        int effort = current.effort;
        int r = current.r;
        int c = current.c;

        // If we've already found a path to this cell with less effort, skip
        if (effort > dist[r][c]) {
            continue;
        }

        // If we reached the destination, this is the minimum effort path
        if (r == rows - 1 && c == cols - 1) {
            // Free allocated memory before returning
            for (int i = 0; i < rows; i++) {
                free(dist[i]);
            }
            free(dist);
            free(heap);
            return effort;
        }

        // Explore neighbors
        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            // Check if neighbor is within grid bounds
            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                // Calculate new effort for this path
                int new_effort = max(effort, abs(heights[r][c] - heights[nr][nc]));

                // If this path is better than previous paths to (nr, nc)
                if (new_effort < dist[nr][nc]) {
                    dist[nr][nc] = new_effort;
                    heap_push(heap, &heap_size, heap_capacity, new_effort, nr, nc);
                }
            }
        }
    }

    // This part should ideally not be reached as a path is guaranteed
    // Free memory in case of unexpected termination
    for (int i = 0; i < rows; i++) {
        free(dist[i]);
    }
    free(dist);
    free(heap);
    return -1; // Indicate error or no path found
}