#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long gcd(long long a, long long b) {
    if (b == 0) {
        return a;
    }
    return gcd(b, a % b);
}

long long lcm(long long a, long long b) {
    return (a * b) / gcd(a, b);
}

int nthUglyNumber(int n, int a, int b, int c) {
    long long l = 1, r = 2e9;
    long long ab = lcm(a, b);
    long long ac = lcm(a, c);
    long long bc = lcm(b, c);
    long long abc = lcm(ab, c);

    while (l < r) {
        long long mid = l + (r - l) / 2;
        long long count = mid / a + mid / b + mid / c - mid / ab - mid / ac - mid / bc + mid / abc;
        if (count < n) {
            l = mid + 1;
        } else {
            r = mid;
        }
    }
    return (int)l;
}