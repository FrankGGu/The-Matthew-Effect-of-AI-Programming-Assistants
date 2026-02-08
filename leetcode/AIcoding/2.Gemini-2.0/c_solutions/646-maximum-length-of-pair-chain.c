#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int**)a)[0][1] - ((int**)b)[0][1];
}

int findLongestChain(int** pairs, int pairsSize, int* pairsColSize) {
    qsort(pairs, pairsSize, sizeof(pairs[0]), compare);

    int current_end = pairs[0][1];
    int count = 1;

    for (int i = 1; i < pairsSize; i++) {
        if (pairs[i][0] > current_end) {
            count++;
            current_end = pairs[i][1];
        }
    }

    return count;
}