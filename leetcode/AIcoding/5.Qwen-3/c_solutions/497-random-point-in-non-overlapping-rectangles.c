#include <stdio.h>
#include <stdlib.h>
#include <time.h>

typedef struct {
    int x1;
    int y1;
    int x2;
    int y2;
} Rectangle;

typedef struct {
    int** rectangles;
    int rectCount;
    int* area;
    int totalArea;
} Solution;

Solution* solutionCreate(int** rects, int rectsSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->rectCount = rectsSize;
    obj->rectangles = (int**)malloc(rectsSize * sizeof(int*));
    for (int i = 0; i < rectsSize; ++i) {
        obj->rectangles[i] = (int*)malloc(4 * sizeof(int));
        obj->rectangles[i][0] = rects[i][0];
        obj->rectangles[i][1] = rects[i][1];
        obj->rectangles[i][2] = rects[i][2];
        obj->rectangles[i][3] = rects[i][3];
    }
    obj->area = (int*)malloc(rectsSize * sizeof(int));
    obj->totalArea = 0;
    for (int i = 0; i < rectsSize; ++i) {
        int width = obj->rectangles[i][2] - obj->rectangles[i][0];
        int height = obj->rectangles[i][3] - obj->rectangles[i][1];
        obj->area[i] = width * height;
        obj->totalArea += obj->area[i];
    }
    return obj;
}

int* solutionPick(Solution* obj, int* retSize) {
    int randNum = rand() % obj->totalArea;
    for (int i = 0; i < obj->rectCount; ++i) {
        if (randNum < obj->area[i]) {
            int x1 = obj->rectangles[i][0];
            int y1 = obj->rectangles[i][1];
            int x2 = obj->rectangles[i][2];
            int y2 = obj->rectangles[i][3];
            int x = x1 + rand() % (x2 - x1);
            int y = y1 + rand() % (y2 - y1);
            int* result = (int*)malloc(2 * sizeof(int));
            result[0] = x;
            result[1] = y;
            *retSize = 2;
            return result;
        }
        randNum -= obj->area[i];
    }
    return NULL;
}

void solutionFree(Solution* obj) {
    for (int i = 0; i < obj->rectCount; ++i) {
        free(obj->rectangles[i]);
    }
    free(obj->rectangles);
    free(obj->area);
    free(obj);
}