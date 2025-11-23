#include <stdio.h>
#include <stdlib.h>

long long maxCandies(int* candies, int candiesSize, int k) {
    long long left = 0;
    long long right = 0;
    for (int i = 0; i < candiesSize; i++) {
        right += candies[i];
    }
    right /= k;

    long long answer = 0;
    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long count = 0;
        for (int i = 0; i < candiesSize; i++) {
            count += candies[i] / mid;
        }
        if (count >= k) {
            answer = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return answer;
}