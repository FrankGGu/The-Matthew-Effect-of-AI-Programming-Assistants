#include <limits.h>
#include <stdlib.h> // For malloc, free
#include <string.h> // For memset

int dr[] = {-1, 1, 0, 0};
int dc[] = {0, 0, -1, 1};

typedef struct {
    int time;
    int r;
    int c;
} HeapNode;

HeapNode* heap;
int heap_capacity;
int heap_size;

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(int idx) {
    while (idx > 0) {
        int parent_idx = (idx - 1) / 2;
        if (heap[idx].time < heap[parent_idx].time) {
            swap(&heap[idx], &heap[parent_idx]);
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

        if (left_child_idx < heap_size && heap[left_child_idx].time < heap[smallest_idx].time) {
            smallest_idx = left_child_idx;
        }
        if (right_child_idx < heap_size && heap[right_child_idx].time < heap[smallest_idx].time) {
            smallest_idx = right_child_idx;
        }

        if (smallest_idx != idx) {
            swap(&heap[idx], &heap[smallest_idx]);
            idx = smallest_idx;
        } else {
            break;
        }
    }
}

void heap_push(int time, int r, int c) {
    if (heap_size == heap_capacity) {
        return; 
    }
    heap[heap_size].time = time;
    heap[heap_size].r = r;
    heap[heap_size].c = c;
    heapify_up(heap_size);
    heap_size++;
}

HeapNode heap_pop() {
    HeapNode min_node = heap[0];
    heap[0] = heap[heap_size - 1];
    heap_size--;
    heapify_down(0);
    return min_node;
}

int heap_is_empty() {
    return heap_size == 0;
}

int minimumTime(int** grid, int gridSize, int* gridColSize) {
    int m = gridSize;
    int n = gridColSize[0];

    if (m == 1 && n == 1) {
        return grid[0][0];
    }

    // Special edge case handling for the starting room (0,0)
    // If grid[0][0] is 0, and both immediate neighbors (0,1) and (1,0) have values > 1,
    // it's impossible to make the first move according to an implicit rule.
    // This condition applies only if m > 1 and n > 1.
    if (grid[0][0] == 0 && m > 1 && n > 1 && grid[0][1] > 1 && grid[1][0] > 1) {
        return -1;
    }

    // dist[r][c] stores the minimum global time to arrive at room (r, c)
    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; ++i) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; ++j) {
            dist[i][j] = INT_MAX;
        }
    }

    heap_capacity = m * n;
    heap = (HeapNode*)malloc(heap_capacity * sizeof(HeapNode));
    heap_size = 0;

    dist[0][0] = 0;
    heap_push(0, 0, 0);

    while (!heap_is_empty()) {
        HeapNode current = heap_pop();
        int t_arrive_rc = current.time;
        int r = current.r;
        int c = current.c;

        if (t_arrive_rc > dist[r][c]) {
            continue;
        }

        // If we reached the destination
        if (r == m - 1 && c == n - 1) {
            int result = dist[m - 1][n - 1];
            for (int i = 0; i < m; ++i) {
                free(dist[i]);
            }
            free(dist);
            free(heap);
            return result;
        }

        // Calculate the effective time to depart from (r,c)
        // You must wait in room (r,c) until at least grid[r][c]
        int t_depart_rc = (t_arrive_rc < grid[r][c]) ? grid[r][c] : t_arrive_rc;

        for (int i = 0; i < 4; ++i) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                // Calculate the candidate arrival time at (nr,nc)
                // It takes 1 unit of time to move.
                // You must arrive at (nr,nc) at a time that is at least grid[nr][nc].
                int t_arrive_nc_candidate = t_depart_rc + 1;
                if (t_arrive_nc_candidate < grid[nr][nc]) {
                    t_arrive_nc_candidate = grid[nr][nc];
                }

                // If this is a shorter path to (nr,nc)
                if (t_arrive_nc_candidate < dist[nr][nc]) {
                    dist[nr][nc] = t_arrive_nc_candidate;
                    heap_push(t_arrive_nc_candidate, nr, nc);
                }
            }
        }
    }

    // If target is unreachable
    for (int i = 0; i < m; ++i) {
        free(dist[i]);
    }
    free(dist);
    free(heap);
    return -1;
}