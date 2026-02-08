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

int nthUglyNumber(int n, int a, int b, int c) {
    long long left = 1;
    long long right = 2e18;

    while (left < right) {
        long long mid = left + (right - left) / 2;
        long long count = mid / a + mid / b + mid / c - mid / lcm(a, b) - mid / lcm(a, c) - mid / lcm(b, c) + mid / lcm(lcm(a, b), c);

        if (count < n)
            left = mid + 1;
        else
            right = mid;
    }

    return (int)left;
}