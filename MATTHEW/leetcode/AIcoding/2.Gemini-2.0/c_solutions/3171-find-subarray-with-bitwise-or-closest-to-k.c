#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int closestToK(int* arr, int arrSize, int k) {
    int minDiff = INT_MAX;
    int result = -1;

    for (int i = 0; i < arrSize; i++) {
        int currentOr = 0;
        for (int j = i; j < arrSize; j++) {
            currentOr |= arr[j];
            int diff = abs(currentOr - k);
            if (diff < minDiff) {
                minDiff = diff;
                result = currentOr;
            } else if (diff == minDiff && currentOr < result) {
                result = currentOr;
            }
        }
    }

    return result;
}