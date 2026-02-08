#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    int x = *(int*)a;
    int y = *(int*)b;
    return x - y;
}

int compareFreq(const void *a, const void *b) {
    int countA = *(int*)a;
    int countB = *(int*)b;
    return countA - countB;
}

int* frequencySort(int* nums, int numsSize, int* returnSize) {
    int* result = (int*)malloc(numsSize * sizeof(int));
    int* freq = (int*)calloc(numsSize, sizeof(int));
    int* temp = (int*)malloc(numsSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < numsSize; i++) {
        temp[i] = nums[i];
    }

    qsort(temp, numsSize, sizeof(int), compare);

    int count = 1;
    for (int i = 1; i < numsSize; i++) {
        if (temp[i] == temp[i - 1]) {
            count++;
        } else {
            for (int j = 0; j < count; j++) {
                freq[index++] = temp[i - 1];
            }
            count = 1;
        }
    }
    for (int j = 0; j < count; j++) {
        freq[index++] = temp[numsSize - 1];
    }

    qsort(freq, numsSize, sizeof(int), compareFreq);

    *returnSize = numsSize;
    return freq;
}