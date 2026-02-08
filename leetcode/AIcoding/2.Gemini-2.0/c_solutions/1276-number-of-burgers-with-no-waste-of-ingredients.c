#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* numOfBurgers(int tomatoSlices, int cheeseSlices, int* returnSize) {
    int jumbo = (tomatoSlices - 2 * cheeseSlices) / 2;
    int small = cheeseSlices - jumbo;

    if (jumbo >= 0 && small >= 0 && 4 * jumbo + 2 * small == tomatoSlices && jumbo + small == cheeseSlices) {
        int* result = (int*)malloc(2 * sizeof(int));
        result[0] = jumbo;
        result[1] = small;
        *returnSize = 2;
        return result;
    } else {
        *returnSize = 0;
        return NULL;
    }
}