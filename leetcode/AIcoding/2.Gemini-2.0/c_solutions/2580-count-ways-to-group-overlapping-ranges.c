#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return ((int*)a)[0] - ((int*)b)[0];
}

int countWays(int** ranges, int rangesSize, int* rangesColSize) {
    qsort(ranges, rangesSize, sizeof(ranges[0]), compare);

    int count = 1;
    int end = ranges[0][1];

    for (int i = 1; i < rangesSize; i++) {
        if (ranges[i][0] > end) {
            count++;
        }
        end = (end > ranges[i][1]) ? end : ranges[i][1];
    }

    long long result = 1;
    long long mod = 1000000007;
    for (int i = 0; i < count; i++) {
        result = (result * 2) % mod;
    }

    return (int)result;
}