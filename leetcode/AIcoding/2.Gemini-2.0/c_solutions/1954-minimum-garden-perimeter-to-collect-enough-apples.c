#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumPerimeter(long long neededApples) {
    long long low = 0, high = 100000;
    long long ans = high;
    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long apples = 2 * mid * (mid + 1) * (2 * mid + 1);
        if (apples >= neededApples) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }
    return ans * 8;
}