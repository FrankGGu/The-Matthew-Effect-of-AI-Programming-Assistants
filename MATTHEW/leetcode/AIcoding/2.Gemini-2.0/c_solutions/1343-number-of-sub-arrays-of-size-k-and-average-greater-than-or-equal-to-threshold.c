#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numOfSubarrays(int* arr, int arrSize, int k, int threshold) {
    int count = 0;
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += arr[i];
    }
    if (sum >= (long)k * threshold) {
        count++;
    }
    for (int i = k; i < arrSize; i++) {
        sum += arr[i] - arr[i - k];
        if (sum >= (long)k * threshold) {
            count++;
        }
    }
    return count;
}