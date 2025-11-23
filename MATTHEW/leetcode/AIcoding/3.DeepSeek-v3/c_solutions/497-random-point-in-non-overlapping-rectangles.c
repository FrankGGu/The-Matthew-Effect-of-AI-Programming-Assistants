#include <stdlib.h>
#include <stdio.h>

typedef struct {
    int* rects;
    int rectsSize;
    int* prefixSums;
    int totalPoints;
} Solution;

Solution* solutionCreate(int** rects, int rectsSize, int* rectsColSize) {
    Solution* obj = (Solution*)malloc(sizeof(Solution));
    obj->rects = (int*)malloc(rectsSize * 4 * sizeof(int));
    obj->rectsSize = rectsSize;
    obj->prefixSums = (int*)malloc(rectsSize * sizeof(int));
    obj->totalPoints = 0;

    for (int i = 0; i < rectsSize; i++) {
        for (int j = 0; j < 4; j++) {
            obj->rects[i * 4 + j] = rects[i][j];
        }
        int width = rects[i][2] - rects[i][0] + 1;
        int height = rects[i][3] - rects[i][1] + 1;
        obj->totalPoints += width * height;
        obj->prefixSums[i] = obj->totalPoints;
    }

    return obj;
}

int* solutionPick(Solution* obj, int* retSize) {
    *retSize = 2;
    int* point = (int*)malloc(2 * sizeof(int));

    int randomPoint = rand() % obj->totalPoints + 1;

    int left = 0, right = obj->rectsSize - 1;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (obj->prefixSums[mid] < randomPoint) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    int rectIndex = left;
    int prevPoints = (rectIndex == 0) ? 0 : obj->prefixSums[rectIndex - 1];
    int pointInRect = randomPoint - prevPoints - 1;

    int width = obj->rects[rectIndex * 4 + 2] - obj->rects[rectIndex * 4 + 0] + 1;
    int x = obj->rects[rectIndex * 4 + 0] + pointInRect % width;
    int y = obj->rects[rectIndex * 4 + 1] + pointInRect / width;

    point[0] = x;
    point[1] = y;

    return point;
}

void solutionFree(Solution* obj) {
    free(obj->rects);
    free(obj->prefixSums);
    free(obj);
}

/**
 * Your Solution struct will be instantiated and called as such:
 * Solution* obj = solutionCreate(rects, rectsSize, rectsColSize);
 * int* param_1 = solutionPick(obj, retSize);

 * solutionFree(obj);
*/