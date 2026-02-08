#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maximizeTheTotal(int* height, int heightSize, int* width, int widthSize, int* numberOfTowers, int numberOfTowersSize) {
    int totalHeight = 0;
    int* sortedHeights = (int*)malloc(heightSize * sizeof(int));
    for (int i = 0; i < heightSize; i++) {
        sortedHeights[i] = height[i];
    }
    qsort(sortedHeights, heightSize, sizeof(int), compare);

    int* towers = (int*)malloc(numberOfTowersSize * sizeof(int));
    for (int i = 0; i < numberOfTowersSize; i++) {
        towers[i] = numberOfTowers[i];
    }
    qsort(towers, numberOfTowersSize, sizeof(int), compare);

    int index = 0;
    for (int i = 0; i < numberOfTowersSize; i++) {
        int count = towers[i];
        for (int j = 0; j < count; j++) {
            if (index < heightSize) {
                totalHeight += sortedHeights[index];
                index++;
            }
        }
    }

    free(sortedHeights);
    free(towers);
    return totalHeight;
}