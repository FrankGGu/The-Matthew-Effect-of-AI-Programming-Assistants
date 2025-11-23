#include <stdio.h>
#include <stdlib.h>

struct Node {
    int count;
    int value;
};

int cmp(const void *a, const void *b) {
    return ((struct Node *)b)->count - ((struct Node *)a)->count;
}

int* rearrangeBarcodes(int* barcodes, int barcodesSize, int* returnSize) {
    int* result = (int*)malloc(sizeof(int) * barcodesSize);
    int count[10001] = {0};
    struct Node nodes[10001];
    int uniqueCount = 0;

    for (int i = 0; i < barcodesSize; i++) {
        count[barcodes[i]]++;
    }

    for (int i = 0; i < 10001; i++) {
        if (count[i] > 0) {
            nodes[uniqueCount].count = count[i];
            nodes[uniqueCount].value = i;
            uniqueCount++;
        }
    }

    qsort(nodes, uniqueCount, sizeof(struct Node), cmp);

    int index = 0;
    for (int i = 0; i < uniqueCount; i++) {
        for (int j = 0; j < nodes[i].count; j++) {
            result[index] = nodes[i].value;
            index += 2;
            if (index >= barcodesSize) {
                index = 1;
            }
        }
    }

    *returnSize = barcodesSize;
    return result;
}