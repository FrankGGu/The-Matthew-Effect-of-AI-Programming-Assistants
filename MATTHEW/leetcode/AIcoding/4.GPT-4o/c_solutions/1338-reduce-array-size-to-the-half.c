#include <stdio.h>
#include <stdlib.h>

int cmp(const void *a, const void *b) {
    return (*(int *)b - *(int *)a);
}

int minSetSize(int* arr, int arrSize) {
    int count[100001] = {0};
    for (int i = 0; i < arrSize; i++) {
        count[arr[i]]++;
    }

    int frequencies[100001], freqSize = 0;
    for (int i = 0; i < 100001; i++) {
        if (count[i] > 0) {
            frequencies[freqSize++] = count[i];
        }
    }

    qsort(frequencies, freqSize, sizeof(int), cmp);

    int half = arrSize / 2, sum = 0, sets = 0;
    for (int i = 0; i < freqSize; i++) {
        sum += frequencies[i];
        sets++;
        if (sum >= half) {
            return sets;
        }
    }

    return sets;
}