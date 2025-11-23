#include <stdio.h>
#include <stdlib.h>

int* findArray(int* subsetSums, int subsetSumsSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * subsetSumsSize);
    *returnSize = subsetSumsSize;
    int n = subsetSumsSize;
    int* freq = (int*)calloc(n + 1, sizeof(int));
    for (int i = 0; i < subsetSumsSize; i++) {
        freq[subsetSums[i]]++;
    }
    int k = 0;
    for (int i = 0; i < n; i++) {
        if (freq[i] > 0) {
            result[k++] = i;
            freq[i]--;
            for (int j = i + 1; j < n; j++) {
                freq[j] -= freq[j - i];
            }
        }
    }
    free(freq);
    return result;
}