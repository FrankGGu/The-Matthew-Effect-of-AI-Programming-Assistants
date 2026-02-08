#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

int maximizeTotalHeight(int* height, int heightSize) {
    qsort(height, heightSize, sizeof(int), cmp);

    int totalHeight = 0;
    int maxHeight = height[0];
    totalHeight += maxHeight;

    for (int i = 1; i < heightSize; i++) {
        if (height[i] < maxHeight) {
            maxHeight = height[i];
            totalHeight += maxHeight;
        } else if (maxHeight > 1){
            maxHeight--;
            totalHeight += maxHeight;
        } else {
            break;
        }
    }

    return totalHeight;
}