#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int r, c, dist;
} HeapNode;

typedef struct {
    HeapNode *nodes;
    int capacity;
    int size;
} MinHeap;

void swap(HeapNode *a, HeapNode *b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_up(MinHeap *heap, int idx) {
    while (idx > 0 && heap->nodes[idx].dist < heap->nodes[(idx - 1) / 2].dist) {
        swap(&heap->nodes[idx], &heap->nodes[(idx - 1) / 2]);
        idx = (idx - 1) / 2;
    }
}

void heapify_down(MinHeap *heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->nodes[left].dist < heap->nodes[smallest].dist) {
        smallest = left;
    }
    if (right < heap->size && heap->nodes[right].dist < heap->nodes[smallest].dist) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap->nodes[idx], &heap->nodes[smallest]);
        heapify_down(heap, smallest);
    }
}

void push(MinHeap *heap, int r, int c, int dist) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->nodes = (HeapNode *)realloc(heap->nodes, heap->capacity * sizeof(HeapNode));
    }
    heap->nodes[heap->size++] = (HeapNode){r, c, dist};
    heapify_up(heap, heap->size - 1);
}

HeapNode pop(MinHeap *heap) {
    if (heap->size == 0) {
        return (HeapNode){-1, -1, -1};
    }
    HeapNode root = heap->nodes[0];
    heap->nodes[0] = heap->nodes[--heap->size];
    heapify_down(heap, 0);
    return root;
}

MinHeap* create_min_heap(int capacity) {
    MinHeap *heap = (MinHeap *)malloc(sizeof(MinHeap));
    heap->nodes = (HeapNode *)malloc(capacity * sizeof(HeapNode));
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void free_min_heap(MinHeap *heap) {
    free(heap->nodes);
    free(heap);
}

int minCostStuntArena(int** grid, int gridSize, int* gridColSize) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        return 0;
    }

    int rows = gridSize;
    int cols = gridColSize[0];

    int** dist = (int**)malloc(rows * sizeof(int*));
    for (int i = 0; i < rows; i++) {
        dist[i] = (int*)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    MinHeap *pq = create_min_heap(rows * cols);

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    dist[0][0] = grid[0][0];
    push(pq, 0, 0, grid[0][0]);

    while (pq->size > 0) {
        HeapNode current = pop(pq);
        int r = current.r;
        int c = current.c;
        int d = current.dist;

        if (d > dist[r][c]) {
            continue;
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < rows && nc >= 0 && nc < cols) {
                int new_cost = d + grid[nr][nc];
                if (new_cost < dist[nr][nc]) {
                    dist[nr][nc] = new_cost;
                    push(pq, nr, nc, new_cost);
                }
            }
        }
    }

    int min_total_cost = dist[rows - 1][cols - 1];

    for (int i = 0; i < rows; i++) {
        free(dist[i]);
    }
    free(dist);
    free_min_heap(pq);

    return min_total_cost;
}