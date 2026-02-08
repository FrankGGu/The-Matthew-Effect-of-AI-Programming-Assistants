#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    return *(int *)b - *(int *)a;
}

int minSetSize(int* arr, int arrSize){
    int counts[100001] = {0};
    for (int i = 0; i < arrSize; i++) {
        counts[arr[i]]++;
    }

    int freq[100001] = {0};
    int freqSize = 0;
    for (int i = 0; i < 100001; i++) {
        if (counts[i] > 0) {
            freq[freqSize++] = counts[i];
        }
    }

    qsort(freq, freqSize, sizeof(int), cmp);

    int removed = 0;
    int numSets = 0;
    for (int i = 0; i < freqSize; i++) {
        removed += freq[i];
        numSets++;
        if (removed >= arrSize / 2) {
            return numSets;
        }
    }

    return numSets;
}