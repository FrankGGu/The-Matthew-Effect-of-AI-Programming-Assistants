#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestCombination(int* candidates, int candidatesSize) {
    int maxCombination = 0;
    for (int bit = 0; bit < 32; bit++) {
        int count = 0;
        for (int i = 0; i < candidatesSize; i++) {
            if ((candidates[i] >> bit) & 1) {
                count++;
            }
        }
        if (count > maxCombination) {
            maxCombination = count;
        }
    }
    return maxCombination;
}