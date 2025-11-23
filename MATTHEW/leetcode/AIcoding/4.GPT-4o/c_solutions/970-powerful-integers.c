#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int* powerfulIntegers(int x, int y, int bound, int* returnSize) {
    int* result = (int*)malloc(100 * sizeof(int));
    int count = 0;
    for (int i = 0; pow(x, i) < bound; i++) {
        for (int j = 0; pow(y, j) < bound; j++) {
            int value = pow(x, i) + pow(y, j);
            if (value <= bound) {
                int found = 0;
                for (int k = 0; k < count; k++) {
                    if (result[k] == value) {
                        found = 1;
                        break;
                    }
                }
                if (!found) {
                    result[count++] = value;
                }
            }
            if (y == 1) break;
        }
        if (x == 1) break;
    }
    *returnSize = count;
    result = (int*)realloc(result, count * sizeof(int));
    return result;
}