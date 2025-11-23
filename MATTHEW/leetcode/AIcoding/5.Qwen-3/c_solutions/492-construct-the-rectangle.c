#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* constructRectangle(int area, int* returnSize) {
    int* result = (int*)malloc(2 * sizeof(int));
    int max = (int)sqrt(area);
    for (int i = max; i >= 1; i--) {
        if (area % i == 0) {
            result[0] = area / i;
            result[1] = i;
            break;
        }
    }
    *returnSize = 2;
    return result;
}