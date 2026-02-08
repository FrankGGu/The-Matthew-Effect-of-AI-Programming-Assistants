#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int count;
} Pair;

int compare(const void *a, const void *b) {
    return ((Pair*)b)->count - ((Pair*)a)->count;
}

int* rearrangeBarcodes(int* barcodes, int barcodesSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * barcodesSize);
    *returnSize = barcodesSize;

    Pair* counts = (Pair*)malloc(sizeof(Pair) * 10001);
    for (int i = 0; i < 10001; i++) {
        counts[i].val = i;
        counts[i].count = 0;
    }

    for (int i = 0; i < barcodesSize; i++) {
        counts[barcodes[i]].count++;
    }

    qsort(counts, 10001, sizeof(Pair), compare);

    int index = 0;
    for (int i = 0; i < 10001; i++) {
        for (int j = 0; j < counts[i].count; j++) {
            result[index] = counts[i].val;
            index += 2;
            if (index >= barcodesSize) {
                index = 1;
            }
        }
    }

    free(counts);
    return result;
}