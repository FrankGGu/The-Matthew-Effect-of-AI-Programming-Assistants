#include <stdio.h>
#include <stdlib.h>

int kthSymbol(int n, int k) {
    if (n == 1) return 0;
    int prev = kthSymbol(n - 1, (k + 1) / 2);
    if (k % 2 == 0) {
        return 1 - prev;
    } else {
        return prev;
    }
}