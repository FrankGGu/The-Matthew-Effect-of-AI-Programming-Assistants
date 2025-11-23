#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <stdbool.h>

int powerfulIntegers(int x, int y, int bound, int* returnSize) {
    bool* exists = (bool*)calloc(bound + 1, sizeof(bool));
    int count = 0;

    for (int i = 0; pow(x, i) < bound; i++) {
        for (int j = 0; pow(y, j) < bound; j++) {
            int pInt = pow(x, i) + pow(y, j);
            if (pInt <= bound) {
                if (!exists[pInt]) {
                    exists[pInt] = true;
                    count++;
                }
            } else {
                break;
            }
            if (y == 1) break; // No need to continue if y is 1
        }
        if (x == 1) break; // No need to continue if x is 1
    }

    free(exists);
    *returnSize = count;
    return count;
}