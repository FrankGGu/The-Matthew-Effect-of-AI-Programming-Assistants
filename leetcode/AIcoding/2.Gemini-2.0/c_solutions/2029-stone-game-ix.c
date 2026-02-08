#include <stdio.h>
#include <stdlib.h>
#include <string.h>

bool stoneGameIX(int* stones, int stonesSize) {
    int count0 = 0, count1 = 0, count2 = 0;
    for (int i = 0; i < stonesSize; i++) {
        if (stones[i] % 3 == 0) {
            count0++;
        } else if (stones[i] % 3 == 1) {
            count1++;
        } else {
            count2++;
        }
    }
    if (count0 % 2 == 0) {
        return (count1 >= 1 && count2 >= 1);
    } else {
        return abs(count1 - count2) > 2;
    }
}