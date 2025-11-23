#include <stdio.h>
#include <stdlib.h>

#define MAX_BITS 30

typedef struct {
    int val;
    int count;
} BitCount;

int compare(const void *a, const void *b) {
    return ((BitCount *)b)->count - ((BitCount *)a)->count;
}

int countBits(int n) {
    int count = 0;
    while (n) {
        count += n & 1;
        n >>= 1;
    }
    return count;
}

long long countExcellentPairs(int* nums, int numsSize, int k) {
    int *bitCounts = (int *)calloc(200001, sizeof(int));
    int uniqueCount = 0;

    for (int i = 0; i < numsSize; i++) {
        if (bitCounts[nums[i]] == 0) uniqueCount++;
        bitCounts[nums[i]]++;
    }

    BitCount *counts = (BitCount *)malloc(uniqueCount * sizeof(BitCount));
    int index = 0;

    for (int i = 0; i < 200001; i++) {
        if (bitCounts[i] > 0) {
            counts[index].val = i;
            counts[index].count = countBits(i);
            index++;
        }
    }

    qsort(counts, uniqueCount, sizeof(BitCount), compare);

    long long result = 0;
    int j = uniqueCount - 1;

    for (int i = 0; i < uniqueCount; i++) {
        while (j >= 0 && counts[i].count + counts[j].count > k) {
            j--;
        }
        result += (j + 1);
    }

    free(bitCounts);
    free(counts);

    return result;
}