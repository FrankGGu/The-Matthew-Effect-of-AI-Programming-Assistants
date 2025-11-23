#include <stdio.h>
#include <stdlib.h>

int* findLonely(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int count = 0;
    int freq[100001] = {0};

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    for (int i = 0; i < numsSize; i++) {
        if (freq[nums[i]] == 1 && (nums[i] == 0 || freq[nums[i] - 1] == 0) && (nums[i] == 100000 || freq[nums[i] + 1] == 0)) {
            result[count++] = nums[i];
        }
    }

    *returnSize = count;
    return result;
}