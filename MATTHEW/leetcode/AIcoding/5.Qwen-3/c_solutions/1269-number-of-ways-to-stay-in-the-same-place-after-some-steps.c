#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numWays(int n, int k) {
    if (n == 0) return 1;
    if (k == 1) return 0;
    int prev = k;
    int curr = k;
    for (int i = 2; i <= n; i++) {
        int temp = curr;
        curr = (curr + prev) * (k - 1);
        prev = temp;
    }
    return curr;
}