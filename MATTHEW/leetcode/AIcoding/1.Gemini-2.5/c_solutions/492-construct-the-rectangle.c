#include <math.h>
#include <stdlib.h>

int* constructRectangle(int area, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * 2);
    *returnSize = 2;

    int w = (int)sqrt(area);

    while (area % w != 0) {
        w--;
    }

    result[0] = area / w;
    result[1] = w;

    return result;
}