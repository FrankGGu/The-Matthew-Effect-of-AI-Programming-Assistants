#include <stdio.h>
#include <stdlib.h>

int* numOfBurgers(int tomatoSize, int cheeseSize, int* returnSize) {
    int* result = (int*)malloc(3 * sizeof(int));
    *returnSize = 0;

    for (int x = 0; x <= tomatoSize / 2; x++) {
        int y = (tomatoSize - 2 * x) / 1;
        if (y >= 0 && (x + y) == cheeseSize && (2 * x + y) == tomatoSize) {
            result[0] = x;
            result[1] = y;
            *returnSize = 2;
            return result;
        }
    }

    return result;
}