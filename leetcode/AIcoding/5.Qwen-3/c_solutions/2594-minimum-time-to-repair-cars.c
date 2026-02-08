#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

long long canRepair(long long* cars, int n, long long time) {
    long long total = 0;
    for (int i = 0; i < n; i++) {
        total += time / cars[i];
        if (total >= 1e18) return 1e18;
    }
    return total;
}

long long minTimeToRepairCars(long long* cars, int n) {
    long long left = 0, right = 1e18;
    while (left < right) {
        long long mid = left + (right - left) / 2;
        if (canRepair(cars, n, mid) >= 1e18) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }
    return left;
}