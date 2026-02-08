#include <stdio.h>
#include <stdlib.h>

int isPerfectSquare(int num) {
    if (num < 1) return 0;
    int left = 1, right = num;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        long square = (long)mid * mid;
        if (square == num) return 1;
        else if (square < num) left = mid + 1;
        else right = mid - 1;
    }
    return 0;
}