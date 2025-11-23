#include <stdlib.h>

int compare(const void* a, const void* b) {
    int* rangeA = *(int**)a;
    int* rangeB = *(int**)b;
    if (rangeA[0] == rangeB[0]) {
        return rangeA[1] - rangeB[1];
    }
    return rangeA[0] - rangeB[0];
}

int countWays(int** ranges, int rangesSize, int* rangesColSize) {
    qsort(ranges, rangesSize, sizeof(int*), compare);

    int groups = 0;
    int maxEnd = -1;

    for (int i = 0; i < rangesSize; i++) {
        if (ranges[i][0] > maxEnd) {
            groups++;
        }
        if (ranges[i][1] > maxEnd) {
            maxEnd = ranges[i][1];
        }
    }

    long long result = 1;
    long long mod = 1000000007;
    for (int i = 0; i < groups; i++) {
        result = (result * 2) % mod;
    }

    return (int)result;
}