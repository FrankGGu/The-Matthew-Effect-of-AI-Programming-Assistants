#include <stdbool.h>
#include <stdlib.h>

bool checkArithmeticSubarray(int* arr, int left, int right) {
    int size = right - left + 1;
    if (size < 2) return true;

    int diff = arr[left + 1] - arr[left];
    for (int i = left + 1; i < right; i++) {
        if (arr[i + 1] - arr[i] != diff) {
            return false;
        }
    }
    return true;
}

bool* checkArithmeticSubarrays(int* arr, int arrSize, int** l, int lSize, int** r, int rSize, bool* returnSize) {
    bool* result = (bool*)malloc(lSize * sizeof(bool));
    *returnSize = lSize;

    for (int i = 0; i < lSize; i++) {
        result[i] = checkArithmeticSubarray(arr, l[i][0], r[i][0]);
    }

    return result;
}