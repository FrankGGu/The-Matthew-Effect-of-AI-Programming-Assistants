#include <stdlib.h>

int cmp(const void *a, const void *b) {
    int countA = *(int*)a;
    int countB = *(int*)b;
    if (countA == countB) {
        return 0;
    }
    return countA < countB ? -1 : 1;
}

int cmpInt(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

int* frequencySort(int* nums, int numsSize, int* returnSize) {
    int freq[20001] = {0};
    int *result = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] + 10000]++;
    }

    int indices[20001];
    for (int i = 0; i < 20001; i++) {
        if (freq[i] > 0) {
            indices[i] = i - 10000;
        } else {
            indices[i] = -1;
        }
    }

    qsort(freq, 20001, sizeof(int), cmp);

    int idx = 0;
    for (int i = 0; i < 20001; i++) {
        if (freq[i] > 0) {
            int num = indices[i];
            int count = freq[i];
            for (int j = 0; j < count; j++) {
                result[idx++] = num;
            }
        }
    }

    *returnSize = numsSize;
    return result;
}