#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* rects;
    int rectsSize;
    int* area_sums;
    int total_area;
} Solution;

int cmp(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

Solution* solutionCreate(int** rects, int rectsSize, int* rectsColSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->rects = (int*)malloc(rectsSize * rectsColSize[0] * sizeof(int));
    obj->area_sums = (int*)malloc(rectsSize * sizeof(int));
    obj->rectsSize = rectsSize;
    obj->total_area = 0;

    for (int i = 0; i < rectsSize; i++) {
        for (int j = 0; j < rectsColSize[0]; j++) {
            obj->rects[i * rectsColSize[0] + j] = rects[i][j];
        }
        int area = (rects[i][2] - rects[i][0] + 1) * (rects[i][3] - rects[i][1] + 1);
        obj->total_area += area;
        obj->area_sums[i] = obj->total_area;
    }

    srand(time(NULL));
    return obj;
}

int* solutionPick(Solution* obj, int* retSize) {
    int rand_area = rand() % obj->total_area + 1;
    int* idx = bsearch(&rand_area, obj->area_sums, obj->rectsSize, sizeof(int), cmp);
    int index = (int)(idx - obj->area_sums);

    int x1 = obj->rects[index * 4 + 0];
    int y1 = obj->rects[index * 4 + 1];
    int x2 = obj->rects[index * 4 + 2];
    int y2 = obj->rects[index * 4 + 3];

    int x = x1 + rand() % (x2 - x1 + 1);
    int y = y1 + rand() % (y2 - y1 + 1);

    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = x;
    result[1] = y;
    *retSize = 2;
    return result;
}

void solutionFree(Solution* obj) {
    free(obj->rects);
    free(obj->area_sums);
    free(obj);
}