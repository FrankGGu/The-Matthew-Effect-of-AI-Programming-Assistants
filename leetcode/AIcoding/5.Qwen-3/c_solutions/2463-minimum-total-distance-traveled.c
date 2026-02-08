#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int* data;
    int size;
} IntArray;

IntArray* createIntArray(int capacity) {
    IntArray* arr = (IntArray*)malloc(sizeof(IntArray));
    arr->data = (int*)malloc(capacity * sizeof(int));
    arr->size = 0;
    return arr;
}

void freeIntArray(IntArray* arr) {
    free(arr->data);
    free(arr);
}

void appendIntArray(IntArray* arr, int value) {
    arr->data[arr->size++] = value;
}

int compareInts(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

int comparePoints(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

int minTotalDistance(int** robot, int robotSize, int* robotColSize, int** factory, int factorySize, int* factoryColSize) {
    qsort(robot, robotSize, sizeof(Point), comparePoints);
    qsort(factory, factorySize, sizeof(Point), comparePoints);

    int* robotX = (int*)malloc(robotSize * sizeof(int));
    int* robotY = (int*)malloc(robotSize * sizeof(int));
    int* factoryX = (int*)malloc(factorySize * sizeof(int));
    int* factoryY = (int*)malloc(factorySize * sizeof(int));

    for (int i = 0; i < robotSize; i++) {
        robotX[i] = robot[i][0];
        robotY[i] = robot[i][1];
    }

    for (int i = 0; i < factorySize; i++) {
        factoryX[i] = factory[i][0];
        factoryY[i] = factory[i][1];
    }

    qsort(robotX, robotSize, sizeof(int), compareInts);
    qsort(robotY, robotSize, sizeof(int), compareInts);
    qsort(factoryX, factorySize, sizeof(int), compareInts);
    qsort(factoryY, factorySize, sizeof(int), compareInts);

    int total = 0;

    for (int i = 0; i < robotSize; i++) {
        int dist = abs(robotX[i] - factoryX[0]) + abs(robotY[i] - factoryY[0]);
        for (int j = 1; j < factorySize; j++) {
            int currDist = abs(robotX[i] - factoryX[j]) + abs(robotY[i] - factoryY[j]);
            if (currDist < dist) {
                dist = currDist;
            }
        }
        total += dist;
    }

    free(robotX);
    free(robotY);
    free(factoryX);
    free(factoryY);

    return total;
}