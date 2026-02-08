#include <stdlib.h>
#include <stdbool.h>
#include <string.h> // For memset or calloc

typedef struct {
    int val;
    int r;
    int c;
} HeapNode;

typedef struct {
    int val;
    int original_idx;
} Query;

int compareQueries(const void* a, const void* b) {
    return ((Query*)a)->val - ((Query*)b)->val;
}

HeapNode* heap_array;
int heap_capacity;
int heap_size;

void init_heap(int capacity) {
    heap_capacity = capacity;
    heap_array = (HeapNode*)malloc(sizeof(HeapNode) * capacity);
    heap_size = 0;
}

void destroy_heap() {
    free(heap_array);
    heap_array = NULL; // Prevent use after free
}

void heapify_up(int idx) {
    while (idx > 0) {
        int parent_idx = (idx - 1) / 2;
        if (heap_array[parent_idx].val > heap_array[idx].val) {
            HeapNode temp = heap_array[parent_idx];
            heap_array[parent_idx] = heap_array[idx];
            heap_array[idx] = temp;
            idx = parent_idx;
        } else {
            break;
        }
    }
}

void heapify_down(int idx) {
    while (1) {
        int left_child_idx = 2 * idx + 1;
        int right_child_idx = 2 * idx + 2;
        int smallest_idx = idx;

        if (left_child_idx < heap_size && heap_array[left_child_idx].val < heap_array[smallest_idx].val) {
            smallest_idx = left_child_idx;
        }

        if (right_child_idx < heap_size && heap_array[right_child_idx].val < heap_array[smallest_idx].val) {
            smallest_idx = right_child_idx;
        }

        if (smallest_idx != idx) {
            HeapNode temp = heap_array[smallest_idx];
            heap_array[smallest_idx] = heap_array[idx];
            heap_array[idx] = temp;
            idx = smallest_idx;
        } else {
            break;
        }
    }
}

void heap_push(HeapNode node) {
    if (heap_size == heap_capacity) {
        // This case should ideally not be hit if capacity is chosen correctly (M*N)
        // For production code, consider reallocating or handling error.
        return; 
    }
    heap_array[heap_size] = node;
    heapify_up(heap_size);
    heap_size++;
}

HeapNode heap_pop() {
    HeapNode root = heap_array[0];
    heap_size--;
    if (heap_size > 0) {
        heap_array[0] = heap_array[heap_size];
        heapify_down(0);
    }
    return root;
}

HeapNode heap_top() {
    return heap_array[0];
}

bool heap_is_empty() {
    return heap_size == 0;
}

int* maxPoints(int** grid, int gridSize, int* gridColSize, int* queries, int queriesSize, int* returnSize) {
    int m = gridSize;
    int n = gridColSize[0];

    *returnSize = queriesSize;
    int* ans = (int*)malloc(sizeof(int) * queriesSize);

    Query* sorted_queries = (Query*)malloc(sizeof(Query) * queriesSize);
    for (int i = 0; i < queriesSize; i++) {
        sorted_queries[i].val = queries[i];
        sorted_queries[i].original_idx = i;
    }
    qsort(sorted_queries, queriesSize, sizeof(Query), compareQueries);

    bool** visited = (bool**)malloc(sizeof(bool*) * m);
    for (int i = 0; i < m; i++) {
        visited[i] = (bool*)calloc(n, sizeof(bool)); // calloc initializes to false
    }

    init_heap(m * n);

    int dr[] = {-1, 1, 0, 0}; // Row offsets for neighbors
    int dc[] = {0, 0, -1, 1}; // Column offsets for neighbors

    // Start from (0,0)
    HeapNode start_node = {grid[0][0], 0, 0};
    heap_push(start_node);
    visited[0][0] = true;

    int reachable_count = 0;
    int query_idx = 0;

    while (query_idx < queriesSize) {
        int current_query_val = sorted_queries[query_idx].val;
        int original_query_idx = sorted_queries[query_idx].original_idx;

        // Process all cells that can be reached with a value strictly less than current_query_val
        while (!heap_is_empty() && heap_top().val < current_query_val) {
            HeapNode current_cell = heap_pop();
            reachable_count++;

            int r = current_cell.r;
            int c = current_cell.c;

            for (int i = 0; i < 4; i++) {
                int nr = r + dr[i];
                int nc = c + dc[i];

                if (nr >= 0 && nr < m && nc >= 0 && nc < n && !visited[nr][nc]) {
                    visited[nr][nc] = true;
                    HeapNode neighbor_node = {grid[nr][nc], nr, nc};
                    heap_push(neighbor_node);
                }
            }
        }
        ans[original_query_idx] = reachable_count;
        query_idx++;
    }

    // Cleanup
    destroy_heap();
    free(sorted_queries);
    for (int i = 0; i < m; i++) {
        free(visited[i]);
    }
    free(visited);

    return ans;
}