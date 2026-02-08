#include <stdio.h>
#include <stdlib.h>

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

void backtrack(int* nums, int numsSize, int k, int start, int* count, int* freq) {
    if (start == numsSize) {
        (*count)++;
        return;
    }

    int num = nums[start];
    if (freq[num - k] == 0 && freq[num + k] == 0) {
        freq[num]++;
        backtrack(nums, numsSize, k, start + 1, count, freq);
        freq[num]--;
    }

    backtrack(nums, numsSize, k, start + 1, count, freq);
}

int beautifulSubsets(int* nums, int numsSize, int k) {
    qsort(nums, numsSize, sizeof(int), compare);
    int count = 0;
    int* freq = (int*)calloc(1001, sizeof(int));
    backtrack(nums, numsSize, k, 0, &count, freq);
    free(freq);
    return count;
}