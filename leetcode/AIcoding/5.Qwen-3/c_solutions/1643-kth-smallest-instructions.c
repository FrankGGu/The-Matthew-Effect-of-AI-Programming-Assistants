#include <stdio.h>
#include <stdlib.h>

long long comb(int n, int k) {
    if (k > n - k) k = n - k;
    long long res = 1;
    for (int i = 0; i < k; ++i) {
        res = res * (n - i) / (i + 1);
    }
    return res;
}

char* kthSmallestPath(char* r, char* c, long long k) {
    int rows = atoi(r);
    int cols = atoi(c);
    int m = rows;
    int n = cols;
    char* res = (char*)malloc((m + n) * sizeof(char));
    int i = 0;
    while (m > 0 && n > 0) {
        long long ways = comb(m + n - 1, m - 1);
        if (k <= ways) {
            res[i++] = 'H';
            m--;
        } else {
            res[i++] = 'V';
            n--;
            k -= ways;
        }
    }
    while (m-- > 0) res[i++] = 'H';
    while (n-- > 0) res[i++] = 'V';
    res[i] = '\0';
    return res;
}