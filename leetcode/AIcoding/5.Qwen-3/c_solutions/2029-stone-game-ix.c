#include <stdio.h>
#include <stdlib.h>

int stoneGameIX(int* stones, int stonesSize) {
    int count[3] = {0};
    for (int i = 0; i < stonesSize; ++i) {
        count[stones[i] % 3]++;
    }

    if (count[1] == 0 || count[2] == 0) {
        return 0;
    }

    int min = (count[1] < count[2]) ? count[1] : count[2];
    return min * 2 < (count[1] + count[2]) ? 1 : 0;
}