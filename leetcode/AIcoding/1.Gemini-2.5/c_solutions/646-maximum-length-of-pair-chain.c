#include <stdlib.h>

int comparePairs(const void *a, const void *b) {
    const int *pairA = *(const int **)a;
    const int *pairB = *(const int **)b;

    if (pairA[1] != pairB[1]) {
        return pairA[1] - pairB[1];
    }
    return pairA[0] - pairB[0];
}

int findLongestChain(int** pairs, int pairsSize, int* pairsColSize) {
    if (pairsSize == 0) {
        return 0;
    }

    qsort(pairs, pairsSize, sizeof(int*), comparePairs);

    int maxLength = 1;
    int currentEnd = pairs[0][1];

    for (int i = 1; i < pairsSize; i++) {
        if (pairs[i][0] > currentEnd) {
            maxLength++;
            currentEnd = pairs[i][1];
        }
    }

    return maxLength;
}