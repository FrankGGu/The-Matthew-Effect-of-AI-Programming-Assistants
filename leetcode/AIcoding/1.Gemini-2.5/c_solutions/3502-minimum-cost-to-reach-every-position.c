#include <limits.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int cost;
    int r;
    int c;
} Cell;

typedef struct {
    Cell* cells;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->cells = (Cell*)malloc(sizeof(Cell) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(Cell* a, Cell* b) {
    Cell temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->cells[index].cost < heap->cells[parent].cost) {
        swap(&heap->cells[index], &heap->cells[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->cells[left].cost < heap->cells[smallest].cost) {
        smallest = left;
    }
    if (right < heap->size && heap->cells[right].cost < heap->cells[smallest].cost) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap->cells[index], &heap->cells[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insertMinHeap(MinHeap* heap, Cell cell) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->cells[heap->size] = cell;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

Cell extractMin(MinHeap* heap) {
    if (heap->size == 0) {
        return (Cell){-1, -1, -1};
    }
    Cell root = heap->cells[0];
    heap->cells[0] = heap->cells[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

bool isMinHeapEmpty(MinHeap* heap) {
    return heap->size == 0;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->cells);
    free(heap);
}

int** minCostToReachEveryPosition(int** grid, int gridSize, int* gridColSize, int* returnSize, int** returnColumnSizes) {
    if (gridSize == 0 || gridColSize[0] == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    int m = gridSize;
    int n = gridColSize[0];

    int** dist = (int**)malloc(m * sizeof(int*));
    for (int i = 0; i < m; i++) {
        dist[i] = (int*)malloc(n * sizeof(int));
        for (int j = 0; j < n; j++) {
            dist[i][j] = INT_MAX;
        }
    }

    int dr[] = {-1, 1, 0, 0};
    int dc[] = {0, 0, -1, 1};

    MinHeap* pq = createMinHeap(m * n);

    dist[0][0] = grid[0][0];
    insertMinHeap(pq, (Cell){dist[0][0], 0, 0});

    while (!isMinHeapEmpty(pq)) {
        Cell current = extractMin(pq);
        int r = current.r;
        int c = current.c;
        int current_cost = current.cost;

        if (current_cost > dist[r][c]) {
            continue;
        }

        for (int i = 0; i < 4; i++) {
            int nr = r + dr[i];
            int nc = c + dc[i];

            if (nr >= 0 && nr < m && nc >= 0 && nc < n) {
                int new_cost = current_cost + grid[nr][nc];

                if (new_cost < dist[nr][nc]) {
                    dist[nr][nc] = new_cost;
                    insertMinHeap(pq, (Cell){new_cost, nr, nc});
                }
            }
        }
    }

    *returnSize = m;
    *returnColumnSizes = (int*)malloc(m * sizeof(int));
    for (int i = 0; i < m; i++) {
        (*returnColumnSizes)[i] = n;
    }

    freeMinHeap(pq);

    return dist;
}