#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minOperations(int* nums, int numsSize, int lower, int upper) {
    int n = numsSize;
    qsort(nums, n, sizeof(int), compare);

    int res = n;
    int j = 0;

    for (int i = 0; i < n; i++) {
        while (j < n && nums[j] <= upper) {
            j++;
        }
        int count = j - i;
        res = (res < (n - count)) ? res : (n - count);

        while (i < n && nums[i] < lower) {
            i++;
        }
    }

    return res;
}