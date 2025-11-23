#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findKthPositive(int* arr, int arrSize, int k) {
    int left = 0, right = arrSize - 1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (arr[mid] - (mid + 1) < k) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return k + left;
}