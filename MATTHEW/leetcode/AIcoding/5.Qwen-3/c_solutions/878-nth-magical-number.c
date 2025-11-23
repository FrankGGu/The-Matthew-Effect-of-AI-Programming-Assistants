#include <stdio.h>
#include <stdlib.h>

long long gcd(long long a, long long b) {
    while (b) {
        long long t = b;
        b = a % b;
        a = t;
    }
    return a;
}

long long lcm(long long a, long long b) {
    return a * b / gcd(a, b);
}

long long nthMagicalNumber(int n, int k) {
    long long MOD = 1000000007;
    long long low = 1, high = (long long)k * n;
    long long LCM = lcm(k, n);

    while (low < high) {
        long long mid = (low + high) / 2;
        long long count = mid / k + mid / n - mid / LCM;

        if (count < n) {
            low = mid + 1;
        } else {
            high = mid;
        }
    }

    return low % MOD;
}