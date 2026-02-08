#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int mySqrt(int x) {
    if (x == 0)
        return 0;

    long long left = 1, right = x;
    long long ans = 0;

    while (left <= right) {
        long long mid = left + (right - left) / 2;

        if (mid * mid <= x) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return (int)ans;
}