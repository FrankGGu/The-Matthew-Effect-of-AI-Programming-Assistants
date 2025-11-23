#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int row;
    int col;
    int height;
} HeapNode;

typedef struct {
    HeapNode *array;
    int size;
    int capacity;
} Heap;

Heap *createHeap(int capacity) {
    Heap *heap = (Heap *)malloc(sizeof(Heap));
    heap->size = 0;
    heap->capacity = capacity;
    heap->array = (HeapNode *)malloc(capacity * sizeof(HeapNode));
    return heap;
}

void swap(HeapNode *a, HeapNode *b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(Heap *heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap->array[index].height >= heap->array[parent].height) break;
        swap(&heap->array[index], &heap->array[parent]);
        index = parent;
    }
}

void heapifyDown(Heap *heap, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->array[left].height < heap->array[smallest].height)
        smallest = left;
    if (right < heap->size && heap->array[right].height < heap->array[smallest].height)
        smallest = right;

    if (smallest != index) {
        swap(&heap->array[index], &heap->array[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insertHeap(Heap *heap, HeapNode node) {
    if (heap->size == heap->capacity) return;
    heap->array[heap->size] = node;
    heapifyUp(heap, heap->size);
    heap->size++;
}

HeapNode extractMin(Heap *heap) {
    if (heap->size == 0) {
        HeapNode invalid = {-1, -1, INT_MAX};
        return invalid;
    }
    HeapNode min = heap->array[0];
    heap->array[0] = heap->array[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return min;
}

int** generateMatrix(int rows, int cols, int** matrix) {
    int **result = (int **)malloc(rows * sizeof(int *));
    for (int i = 0; i < rows; i++) {
        result[i] = (int *)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            result[i][j] = matrix[i][j];
        }
    }
    return result;
}

int trapRainWater(int** heightMap, int heightMapSize, int* heightMapColSize) {
    if (heightMapSize <= 2 || *heightMapColSize <= 2) return 0;

    int rows = heightMapSize;
    int cols = *heightMapColSize;

    int **visited = (int **)malloc(rows * sizeof(int *));
    for (int i = 0; i < rows; i++) {
        visited[i] = (int *)malloc(cols * sizeof(int));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = 0;
        }
    }

    Heap *heap = createHeap(rows * cols);
    for (int i = 0; i < rows; i++) {
        for (int j = 0; j < cols; j++) {
            if (i == 0 || i == rows - 1 || j == 0 || j == cols - 1) {
                HeapNode node = {i, j, heightMap[i][j]};
                insertHeap(heap, node);
                visited[i][j] = 1;
            }
        }
    }

    int dirs[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};
    int result = 0;

    while (heap->size > 0) {
        HeapNode current = extractMin(heap);
        for (int d = 0; d < 4; d++) {
            int newRow = current.row + dirs[d][0];
            int newCol = current.col + dirs[d][1];
            if (newRow >= 0 && newRow < rows && newCol >= 0 && newCol < cols && !visited[newRow][newCol]) {
                visited[newRow][newCol] = 1;
                if (heightMap[newRow][newCol] < current.height) {
                    result += current.height - heightMap[newRow][newCol];
                }
                HeapNode newNode = {newRow, newCol, fmax(current.height, heightMap[newRow][newCol])};
                insertHeap(heap, newNode);
            }
        }
    }

    for (int i = 0; i < rows; i++) free(visited[i]);
    free(visited);
    free(heap->array);
    free(heap);

    return result;
}