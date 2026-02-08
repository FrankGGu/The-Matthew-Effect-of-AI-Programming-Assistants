#include <stdio.h>
#include <stdlib.h>

int arrangeCoins(int n) {
    int left = 1;
    int right = n;
    int result = 0;
    while (left <= right) {
        long mid = (left + right) / 2;
        long total = mid * (mid + 1) / 2;
        if (total == n) {
            return (int)mid;
        } else if (total < n) {
            result = (int)mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return result;
}