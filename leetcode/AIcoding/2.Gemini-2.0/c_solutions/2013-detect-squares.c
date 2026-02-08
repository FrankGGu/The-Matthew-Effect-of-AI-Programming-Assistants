#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int x;
    int y;
    int count;
} PointCount;

typedef struct {
    PointCount* points;
    int size;
    int capacity;
} DetectSquares;

DetectSquares* detectSquaresCreate() {
    DetectSquares* obj = (DetectSquares*)malloc(sizeof(DetectSquares));
    obj->points = (PointCount*)malloc(sizeof(PointCount) * 1001);
    obj->size = 0;
    obj->capacity = 1001;
    return obj;
}

void detectSquaresAdd(DetectSquares* obj, int* point, int pointSize) {
    int x = point[0];
    int y = point[1];
    for (int i = 0; i < obj->size; i++) {
        if (obj->points[i].x == x && obj->points[i].y == y) {
            obj->points[i].count++;
            return;
        }
    }
    if (obj->size == obj->capacity) {
        obj->capacity *= 2;
        obj->points = (PointCount*)realloc(obj->points, sizeof(PointCount) * obj->capacity);
    }
    obj->points[obj->size].x = x;
    obj->points[obj->size].y = y;
    obj->points[obj->size].count = 1;
    obj->size++;
}

int detectSquaresCount(DetectSquares* obj, int* point, int pointSize) {
    int px = point[0];
    int py = point[1];
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        int qx = obj->points[i].x;
        int qy = obj->points[i].y;
        if (qx == px || qy == py) continue;
        int side = abs(qx - px);
        if (abs(qy - py) != side) continue;
        int rx = px;
        int ry = qy;
        int sx = qx;
        int sy = py;
        int r_count = 0;
        int s_count = 0;
        for (int j = 0; j < obj->size; j++) {
            if (obj->points[j].x == rx && obj->points[j].y == ry) {
                r_count = obj->points[j].count;
            }
            if (obj->points[j].x == sx && obj->points[j].y == sy) {
                s_count = obj->points[j].count;
            }
        }
        count += obj->points[i].count * r_count * s_count;
    }
    return count;
}

void detectSquaresFree(DetectSquares* obj) {
    free(obj->points);
    free(obj);
}