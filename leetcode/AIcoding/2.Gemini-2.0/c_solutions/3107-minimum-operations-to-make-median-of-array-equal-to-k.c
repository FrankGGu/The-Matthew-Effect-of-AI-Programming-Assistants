#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)a - *(int *)b;
}

long long minOperations(int* nums, int numsSize, int k) {
    int less = 0, equal = 0, greater = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < k) less++;
        else if (nums[i] == k) equal++;
        else greater++;
    }

    int need = (numsSize + 1) / 2;
    if (less >= need) return need - equal;

    int arr[numsSize];
    int arrSize = 0;
    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < k) continue;
        arr[arrSize++] = nums[i];
    }

    qsort(arr, arrSize, sizeof(int), cmp);

    long long ans = -1;
    for (int i = 0; i <= arrSize - (need - equal); i++) {
        long long cur = 0;
        for (int j = i; j < i + (need - equal); j++) {
            cur += abs(arr[j] - k);
        }

        if (ans == -1 || cur < ans) {
            ans = cur;
        }
    }

    return ans;
}