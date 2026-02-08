#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mySqrt(int x) {
    if (x == 0) return 0;
    if (x == 1) return 1;

    long long left = 1, right = x / 2;
    long long ans = 0;

    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long square = mid * mid;

        if (square == x) {
            return (int)mid;
        } else if (square < x) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return (int)ans;
}