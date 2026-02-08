#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int* rearrangeBarcodes(int* barcodes, int barcodesSize, int* returnSize) {
    if (barcodesSize <= 1) {
        *returnSize = barcodesSize;
        return barcodes;
    }

    int* freq = (int*)calloc(256, sizeof(int));
    for (int i = 0; i < barcodesSize; i++) {
        freq[barcodes[i]]++;
    }

    int maxFreq = 0, maxVal = 0;
    for (int i = 0; i < 256; i++) {
        if (freq[i] > maxFreq) {
            maxFreq = freq[i];
            maxVal = i;
        }
    }

    int* result = (int*)malloc(barcodesSize * sizeof(int));
    int index = 0;

    for (int i = 0; i < maxFreq; i++) {
        for (int j = 0; j < 256; j++) {
            if (freq[j] > 0 && (i != 0 || j != maxVal)) {
                result[index++] = j;
                freq[j]--;
            }
        }
    }

    *returnSize = barcodesSize;
    return result;
}