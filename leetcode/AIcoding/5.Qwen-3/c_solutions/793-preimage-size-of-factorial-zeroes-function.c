#include <stdio.h>
#include <stdlib.h>

int trailingZeroes(int n) {
    int count = 0;
    while (n > 0) {
        n /= 5;
        count += n;
    }
    return count;
}

long long findK(long long left, long long right, int target) {
    while (left < right) {
        long long mid = left + (right - left) / 2;
        if (trailingZeroes(mid) < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}

int preimageSizeF1(int n) {
    long long left = 0;
    long long right = 5 * (long long)n;
    long long k = findK(left, right, n);
    long long cnt = 0;
    while (trailingZeroes(k + cnt) == n) {
        cnt++;
    }
    return (int)cnt;
}