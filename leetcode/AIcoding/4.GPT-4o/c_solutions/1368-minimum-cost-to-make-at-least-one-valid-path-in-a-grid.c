#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int x, y, cost;
} Node;

typedef struct {
    Node *nodes;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap *heap = (MinHeap *)malloc(sizeof(MinHeap));
    heap->nodes = (Node *)malloc(capacity * sizeof(Node));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(Node *a, Node *b) {
    Node temp = *a;
    *a = *b;
    *b = temp;
}

void insertHeap(MinHeap *heap, Node node) {
    if (heap->size == heap->capacity) return;
    heap->nodes[heap->size++] = node;

    for (int i = heap->size - 1; i > 0; ) {
        int parent = (i - 1) / 2;
        if (heap->nodes[i].cost >= heap->nodes[parent].cost) break;
        swap(&heap->nodes[i], &heap->nodes[parent]);
        i = parent;
    }
}

Node extractMin(MinHeap *heap) {
    Node minNode = heap->nodes[0];
    heap->nodes[0] = heap->nodes[--heap->size];
    for (int i = 0; i < heap->size; ) {
        int left = 2 * i + 1, right = 2 * i + 2, smallest = i;
        if (left < heap->size && heap->nodes[left].cost < heap->nodes[smallest].cost) smallest = left;
        if (right < heap->size && heap->nodes[right].cost < heap->nodes[smallest].cost) smallest = right;
        if (smallest == i) break;
        swap(&heap->nodes[i], &heap->nodes[smallest]);
        i = smallest;
    }
    return minNode;
}

bool isInBounds(int x, int y, int rowCount, int colCount) {
    return x >= 0 && x < rowCount && y >= 0 && y < colCount;
}

int minCost(int** grid, int gridSize, int* gridColSize) {
    int rowCount = gridSize, colCount = *gridColSize;
    int directions[4][2] = {{0, 1}, {1, 0}, {0, -1}, {-1, 0}};
    int** costs = (int **)malloc(rowCount * sizeof(int *));
    for (int i = 0; i < rowCount; i++) {
        costs[i] = (int *)malloc(colCount * sizeof(int));
        for (int j = 0; j < colCount; j++) {
            costs[i][j] = INT_MAX;
        }
    }
    costs[0][0] = 0;

    MinHeap *heap = createMinHeap(rowCount * colCount);
    insertHeap(heap, (Node){0, 0, 0});

    while (heap->size > 0) {
        Node current = extractMin(heap);

        if (current.x == rowCount - 1 && current.y == colCount - 1) {
            return current.cost;
        }

        for (int i = 0; i < 4; i++) {
            int newX = current.x + directions[i][0];
            int newY = current.y + directions[i][1];
            if (isInBounds(newX, newY, rowCount, colCount)) {
                int newCost = current.cost + (i + 1 != grid[current.x][current.y]);
                if (newCost < costs[newX][newY]) {
                    costs[newX][newY] = newCost;
                    insertHeap(heap, (Node){newX, newY, newCost});
                }
            }
        }
    }

    return -1;
}