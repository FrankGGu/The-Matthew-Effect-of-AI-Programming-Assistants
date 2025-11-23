#include <stdio.h>
#include <stdlib.h>

long long countHousePlacements(int n) {
    long long a = 1, b = 1;
    for (int i = 2; i <= n; i++) {
        long long c = (a + b) % 1000000007;
        a = b;
        b = c;
    }
    return (b * b) % 1000000007;
}