#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int key;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair *)a)->key - ((Pair *)b)->key;
}

int countAlmostEqualPairs(int* nums, int numsSize) {
    int n = numsSize;
    Pair *freq = (Pair *)malloc(n * sizeof(Pair));
    int freqSize = 0;

    for (int i = 0; i < n; i++) {
        int found = 0;
        for (int j = 0; j < freqSize; j++) {
            if (freq[j].key == nums[i]) {
                freq[j].count++;
                found = 1;
                break;
            }
        }
        if (!found) {
            freq[freqSize].key = nums[i];
            freq[freqSize].count = 1;
            freqSize++;
        }
    }

    qsort(freq, freqSize, sizeof(Pair), compare);

    int result = 0;
    for (int i = 0; i < freqSize; i++) {
        for (int j = i + 1; j < freqSize; j++) {
            int a = freq[i].key;
            int b = freq[j].key;
            int diff = abs(a - b);
            if (diff <= 2) {
                result += freq[i].count * freq[j].count;
            }
        }
    }

    free(freq);
    return result;
}