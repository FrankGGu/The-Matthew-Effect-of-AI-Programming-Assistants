#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair *)b)->count - ((Pair *)a)->count;
}

int* uniqueMiddleModeSubseqs(int* nums, int numsSize, int* returnSize) {
    int n = numsSize;
    int* result = (int*)malloc(n * sizeof(int));
    *returnSize = 0;

    for (int i = 0; i < n; i++) {
        int freq[101] = {0};
        int maxFreq = 0;
        int mode = nums[i];
        for (int j = i; j < n; j++) {
            freq[nums[j]]++;
            if (freq[nums[j]] > maxFreq || (freq[nums[j]] == maxFreq && nums[j] < mode)) {
                maxFreq = freq[nums[j]];
                mode = nums[j];
            }
            if (j - i + 1 == 1) {
                result[*returnSize++] = mode;
            } else if ((j - i + 1) % 2 == 1) {
                int mid = i + (j - i) / 2;
                if (nums[mid] == mode) {
                    result[*returnSize++] = mode;
                }
            }
        }
    }

    return result;
}