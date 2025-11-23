#include <stdio.h>
#include <stdlib.h>

long long numberOfWays(int startPos, int endPos, int k) {
    int diff = abs(endPos - startPos);
    if (diff > k || (k - diff) % 2 != 0) {
        return 0;
    }
    int n = k;
    int m = (k - diff) / 2;
    long long result = 1;
    for (int i = 0; i < m; i++) {
        result = result * (n - i) / (i + 1);
    }
    return result;
}