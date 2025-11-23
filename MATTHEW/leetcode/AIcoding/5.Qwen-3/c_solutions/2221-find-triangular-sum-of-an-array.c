#include <stdio.h>
#include <stdlib.h>

int64_t* getArray(int size) {
    int64_t* arr = (int64_t*)malloc(size * sizeof(int64_t));
    return arr;
}

int64_t* getRow(int64_t* nums, int n) {
    int64_t* row = (int64_t*)malloc(n * sizeof(int64_t));
    for (int i = 0; i < n; i++) {
        row[i] = nums[i];
    }
    return row;
}

int64_t* getTriangularSum(int64_t* nums, int numsSize) {
    int64_t* result = (int64_t*)malloc(numsSize * sizeof(int64_t));
    for (int i = 0; i < numsSize; i++) {
        result[i] = nums[i];
    }
    for (int i = 1; i < numsSize; i++) {
        for (int j = 0; j < numsSize - i; j++) {
            result[j] = result[j] + result[j + 1];
        }
    }
    return result;
}

int64_t* getFinalResult(int64_t* nums, int numsSize) {
    int64_t* result = getTriangularSum(nums, numsSize);
    return result;
}