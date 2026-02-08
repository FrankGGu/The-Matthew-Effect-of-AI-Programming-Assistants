#include <stdlib.h>

int cmp(const void* a, const void* b) {
    return *(long long*)a - *(long long*)b;
}

int maxDistinctElements(int* nums, int numsSize, int k, int m) {
    long long* arr = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        arr[i] = nums[i];
    }
    qsort(arr, numsSize, sizeof(long long), cmp);

    long long prev = arr[0] - m - 1;
    int count = 0;
    for (int i = 0; i < numsSize; i++) {
        long long left = arr[i] - k;
        long long right = arr[i] + k;
        long long start = (left > prev + 1) ? left : prev + 1;
        if (start <= right) {
            count++;
            prev = start;
        }
    }
    free(arr);
    return count;
}