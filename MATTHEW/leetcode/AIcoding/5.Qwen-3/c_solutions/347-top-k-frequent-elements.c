#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)b - *(int*)a);
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    int i;
    int* result = (int*)malloc(k * sizeof(int));
    int* freq = (int*)calloc(numsSize, sizeof(int));
    int* freqIndex = (int*)calloc(numsSize, sizeof(int));

    for (i = 0; i < numsSize; i++) {
        int num = nums[i];
        int found = 0;
        for (int j = 0; j < numsSize; j++) {
            if (freqIndex[j] == num) {
                freq[j]++;
                found = 1;
                break;
            }
        }
        if (!found) {
            for (int j = 0; j < numsSize; j++) {
                if (freqIndex[j] == 0) {
                    freqIndex[j] = num;
                    freq[j] = 1;
                    break;
                }
            }
        }
    }

    qsort(freq, numsSize, sizeof(int), compare);

    int count = 0;
    for (i = 0; i < numsSize && count < k; i++) {
        for (int j = 0; j < numsSize; j++) {
            if (freq[i] == freq[j]) {
                result[count++] = freqIndex[j];
                freq[j] = 0;
                break;
            }
        }
    }

    *returnSize = k;
    return result;
}