#include <stdio.h>
#include <stdlib.h>

int findKthMissingPositive(int* arr, int arrSize, int k) {
    int left = 0, right = arrSize;
    while (left < right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] - mid - 1 < k) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left + k;
}