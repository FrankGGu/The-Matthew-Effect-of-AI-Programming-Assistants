#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int minDeletions(int* nums, int numsSize, int* divisors, int divisorsSize) {
    qsort(nums, numsSize, sizeof(int), compare);

    int* freq = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        freq[nums[i]]++;
    }

    int* count = (int*)calloc(10001, sizeof(int));
    for (int i = 0; i < divisorsSize; i++) {
        int d = divisors[i];
        for (int j = d; j <= 10000; j += d) {
            count[j]++;
        }
    }

    int result = 0;
    for (int i = 10000; i >= 1; i--) {
        if (count[i] == divisorsSize) {
            int del = 0;
            for (int j = 1; j <= i; j++) {
                if (i % j == 0) {
                    del += freq[j];
                }
            }
            return numsSize - del;
        }
    }

    return numsSize;
}