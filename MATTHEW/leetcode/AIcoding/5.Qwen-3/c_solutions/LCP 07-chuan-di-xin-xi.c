#include <stdio.h>
#include <stdlib.h>

int numWays(int n, int k) {
    if (n == 0) return 0;
    if (n == 1) return k;
    int prev = k;
    int curr = k * k;
    for (int i = 2; i < n; i++) {
        int temp = curr;
        curr = (prev + curr) * (k - 1);
        prev = temp;
    }
    return curr;
}