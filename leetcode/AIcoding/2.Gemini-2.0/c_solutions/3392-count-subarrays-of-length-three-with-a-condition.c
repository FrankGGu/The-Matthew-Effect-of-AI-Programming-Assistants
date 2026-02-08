#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int countGoodSubarrays(int* arr, int arrSize, int k) {
    int count = 0;
    for (int i = 0; i <= arrSize - 3; i++) {
        if (abs(arr[i] - arr[i + 1]) <= k &&
            abs(arr[i + 1] - arr[i + 2]) <= k &&
            abs(arr[i] - arr[i + 2]) <= k) {
            count++;
        }
    }
    return count;
}