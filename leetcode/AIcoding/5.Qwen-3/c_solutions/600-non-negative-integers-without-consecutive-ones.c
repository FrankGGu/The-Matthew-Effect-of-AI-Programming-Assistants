#include <stdio.h>
#include <stdlib.h>

int count(int n, int flag) {
    if (n == 0) return 1;
    int res = 0;
    int last = n & 1;
    if (flag) {
        res += count(n >> 1, 0);
    } else {
        res += count(n >> 1, 1);
        if (last) res += count(n >> 1, 0);
    }
    return res;
}

int nonNegativeIntegersWithoutConsecutiveOnes(int n) {
    return count(n, 1);
}