#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int min(int a, int b) {
    return a < b ? a : b;
}

int* largestSquare(int** rectangles, int rectanglesSize, int* rectanglesColSize, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int maxSquare = 0;
    int count = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int side = min(rectangles[i][0], rectangles[i][1]);
        if (side > maxSquare) {
            maxSquare = side;
            count = 1;
        } else if (side == maxSquare) {
            count++;
        }
    }

    result[0] = maxSquare;
    result[1] = count;
    *returnSize = 2;
    return result;
}