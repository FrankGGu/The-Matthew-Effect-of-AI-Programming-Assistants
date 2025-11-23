#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int gcd(int a, int b) {
    if (b == 0) return a;
    return gcd(b, a % b);
}

int nthMagicalNumber(int n, int a, int b) {
    long long l = 2, r = (long long)1e15;
    long long lcm = (long long)a * b / gcd(a, b);
    int mod = 1e9 + 7;
    while (l < r) {
        long long mid = l + (r - l) / 2;
        long long count = mid / a + mid / b - mid / lcm;
        if (count < n) {
            l = mid + 1;
        } else {
            r = mid;
        }
    }
    return l % mod;
}