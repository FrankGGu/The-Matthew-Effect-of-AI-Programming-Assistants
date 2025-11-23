#include <stdlib.h>
#include <string.h>

long long maxRunTime(int n, int* batteries, int batteriesSize) {
    long long left = 1, right = 0;
    for (int i = 0; i < batteriesSize; i++) {
        right += batteries[i];
    }
    right /= n;

    while (left < right) {
        long long mid = right - (right - left) / 2;
        long long total = 0;
        for (int i = 0; i < batteriesSize; i++) {
            total += (batteries[i] < mid) ? batteries[i] : mid;
        }
        if (total >= mid * n) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }
    return left;
}