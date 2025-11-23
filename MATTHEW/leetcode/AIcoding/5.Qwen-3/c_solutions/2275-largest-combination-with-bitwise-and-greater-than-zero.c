#include <stdio.h>
#include <stdlib.h>

int largestCombination(int* candidates, int candidatesSize) {
    int maxCount = 0;
    for (int i = 0; i < 32; i++) {
        int count = 0;
        for (int j = 0; j < candidatesSize; j++) {
            if (candidates[j] & (1 << i)) {
                count++;
            }
        }
        maxCount = (count > maxCount) ? count : maxCount;
    }
    return maxCount;
}