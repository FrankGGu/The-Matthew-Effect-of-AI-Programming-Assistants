#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int numWays(int n) {
    long long a = 6, b = 6;
    for (int i = 1; i < n; i++) {
        long long temp = b;
        b = (2 * a + 3 * b) % 1000000007;
        a = (2 * a + 2 * temp) % 1000000007;
    }
    return (a + b) % 1000000007;
}