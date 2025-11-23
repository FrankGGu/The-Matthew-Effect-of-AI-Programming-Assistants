#include <stdio.h>
#include <stdlib.h>

int findLengthOfShortestSubarray(int* arr, int arrSize) {
    int left = 0;
    while (left < arrSize - 1 && arr[left] <= arr[left + 1]) {
        left++;
    }
    if (left == arrSize - 1) {
        return 0;
    }

    int right = arrSize - 1;
    while (right > 0 && arr[right] >= arr[right - 1]) {
        right--;
    }

    int result = fmin(left + 1, arrSize - right);

    int i = 0, j = right;
    while (i <= left && j < arrSize) {
        if (arr[i] <= arr[j]) {
            result = fmin(result, j - i - 1);
            i++;
        } else {
            j++;
        }
    }

    return result;
}