#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#define MAX(a, b) ((a) > (b) ? (a) : (b))
#define MIN(a, b) ((a) < (b) ? (a) : (b))

typedef struct {
    int x, y;
} Point;

typedef struct {
    Point *points;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap *heap = (MinHeap *)malloc(sizeof(MinHeap));
    heap->points = (Point *)malloc(capacity * sizeof(Point));
    heap->size = 0;
    heap->capacity = capacity;
    return heap;
}

void swap(Point *a, Point *b) {
    Point temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap *heap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->points[left].y < heap->points[smallest].y) {
        smallest = left;
    }
    if (right < heap->size && heap->points[right].y < heap->points[smallest].y) {
        smallest = right;
    }
    if (smallest != idx) {
        swap(&heap->points[smallest], &heap->points[idx]);
        minHeapify(heap, smallest);
    }
}

void insert(MinHeap *heap, Point p) {
    if (heap->size == heap->capacity) return;
    heap->points[heap->size++] = p;
    for (int i = (heap->size - 1) / 2; i >= 0; i--) {
        minHeapify(heap, i);
    }
}

Point extractMin(MinHeap *heap) {
    Point minPoint = heap->points[0];
    heap->points[0] = heap->points[--heap->size];
    minHeapify(heap, 0);
    return minPoint;
}

bool isEmpty(MinHeap *heap) {
    return heap->size == 0;
}

int trapRainWater(int** heightMap, int heightMapSize, int* heightMapColSize) {
    if (heightMapSize == 0 || *heightMapColSize == 0) return 0;

    int totalWater = 0;
    int rows = heightMapSize, cols = *heightMapColSize;
    bool **visited = (bool **)malloc(rows * sizeof(bool *));
    for (int i = 0; i < rows; i++) {
        visited[i] = (bool *)malloc(cols * sizeof(bool));
        for (int j = 0; j < cols; j++) {
            visited[i][j] = false;
        }
    }

    MinHeap *minHeap = createMinHeap(rows * cols);
    for (int i = 0; i < rows; i++) {
        visited[i][0] = visited[i][cols - 1] = true;
        insert(minHeap, (Point){i, 0});
        insert(minHeap, (Point){i, cols - 1});
    }
    for (int j = 0; j < cols; j++) {
        visited[0][j] = visited[rows - 1][j] = true;
        insert(minHeap, (Point){0, j});
        insert(minHeap, (Point){rows - 1, j});
    }

    int directions[4][2] = {{-1, 0}, {1, 0}, {0, -1}, {0, 1}};

    while (!isEmpty(minHeap)) {
        Point curr = extractMin(minHeap);
        for (int i = 0; i < 4; i++) {
            int newX = curr.x + directions[i][0];
            int newY = curr.y + directions[i][1];

            if (newX >= 0 && newX < rows && newY >= 0 && newY < cols && !visited[newX][newY]) {
                visited[newX][newY] = true;
                totalWater += MAX(0, curr.y - heightMap[newX][newY]);
                insert(minHeap, (Point){newX, newY});
            }
        }
    }

    for (int i = 0; i < rows; i++) {
        free(visited[i]);
    }
    free(visited);
    free(minHeap->points);
    free(minHeap);
    return totalWater;
}