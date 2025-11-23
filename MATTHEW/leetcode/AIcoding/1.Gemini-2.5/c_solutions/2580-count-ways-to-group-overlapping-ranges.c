#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    const int *arrA = *(const int **)a;
    const int *arrB = *(const int **)b;
    if (arrA[0] != arrB[0]) {
        return arrA[0] - arrB[0];
    }
    return arrA[1] - arrB[1];
}

long long power(long long base, long long exp) {
    long long res = 1;
    long long mod = 1000000007;
    base %= mod;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % mod;
        base = (base * base) % mod;
        exp /= 2;
    }
    return res;
}

int countWays(int** ranges, int rangesSize, int* rangesColSize){
    if (rangesSize == 0) {
        return 1;
    }

    qsort(ranges, rangesSize, sizeof(int*), compare);

    int count = 0;
    int max_end = -1; 

    for (int i = 0; i < rangesSize; ++i) {
        int start = ranges[i][0];
        int end = ranges[i][1];

        if (start > max_end) {
            count++;
        }

        if (end > max_end) {
            max_end = end;
        }
    }

    return (int)power(2, count);
}