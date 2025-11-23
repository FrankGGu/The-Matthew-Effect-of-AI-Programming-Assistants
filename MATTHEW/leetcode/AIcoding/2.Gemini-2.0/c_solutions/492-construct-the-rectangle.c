#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* constructRectangle(int area, int* returnSize) {
    int w = (int)sqrt(area);
    while (area % w != 0) {
        w--;
    }
    int* result = (int*)malloc(2 * sizeof(int));
    result[0] = area / w;
    result[1] = w;
    *returnSize = 2;
    return result;
}