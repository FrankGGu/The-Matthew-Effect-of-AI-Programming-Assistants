#include <stdio.h>
#include <stdlib.h>

int closestToTarget(int* arr, int arrSize, int target) {
    int minDiff = abs(arr[0] - target);
    int current = arr[0];
    for (int i = 1; i < arrSize; i++) {
        int temp = current & arr[i];
        if (abs(temp - target) < minDiff) {
            minDiff = abs(temp - target);
        }
        current = temp;
    }
    return minDiff;
}