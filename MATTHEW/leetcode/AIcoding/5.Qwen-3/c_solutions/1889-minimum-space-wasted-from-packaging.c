#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minSpaceWastedBF(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    int minWaste = INT_MAX;
    for (int i = 0; i < boxesSize; i++) {
        int box = boxes[i][0];
        int waste = 0;
        for (int j = 0; j < packagesSize; j++) {
            waste += (box - packages[j]);
        }
        if (waste < minWaste) {
            minWaste = waste;
        }
    }
    return minWaste;
}

int minSpaceWastedRF(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    qsort(packages, packagesSize, sizeof(int), compare);
    for (int i = 0; i < boxesSize; i++) {
        qsort(boxes[i], boxesColSize[i], sizeof(int), compare);
    }

    int minWaste = INT_MAX;
    for (int i = 0; i < boxesSize; i++) {
        int* box = boxes[i];
        int boxSize = boxesColSize[i];
        int currentWaste = 0;
        int k = 0;
        for (int j = 0; j < packagesSize; j++) {
            while (k < boxSize && box[k] < packages[j]) {
                k++;
            }
            if (k < boxSize) {
                currentWaste += (box[k] - packages[j]);
            } else {
                currentWaste = INT_MAX;
                break;
            }
        }
        if (currentWaste < minWaste) {
            minWaste = currentWaste;
        }
    }
    return minWaste;
}

int minSpaceWastedOP(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    qsort(packages, packagesSize, sizeof(int), compare);
    for (int i = 0; i < boxesSize; i++) {
        qsort(boxes[i], boxesColSize[i], sizeof(int), compare);
    }

    int minWaste = INT_MAX;
    for (int i = 0; i < boxesSize; i++) {
        int* box = boxes[i];
        int boxSize = boxesColSize[i];
        int currentWaste = 0;
        int k = 0;
        for (int j = 0; j < packagesSize; j++) {
            while (k < boxSize && box[k] < packages[j]) {
                k++;
            }
            if (k < boxSize) {
                currentWaste += (box[k] - packages[j]);
            } else {
                currentWaste = INT_MAX;
                break;
            }
        }
        if (currentWaste < minWaste) {
            minWaste = currentWaste;
        }
    }
    return minWaste;
}

int minSpaceWasted(int* packages, int packagesSize, int** boxes, int boxesSize, int* boxesColSize) {
    return minSpaceWastedOP(packages, packagesSize, boxes, boxesSize, boxesColSize);
}