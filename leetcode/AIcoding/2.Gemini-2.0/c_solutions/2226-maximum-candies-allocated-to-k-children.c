#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maximumCandies(int* candies, int candiesSize, long long k) {
    int left = 1, right = 0;
    for (int i = 0; i < candiesSize; i++) {
        right = (right > candies[i]) ? right : candies[i];
    }
    int ans = 0;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        long long count = 0;
        for (int i = 0; i < candiesSize; i++) {
            count += candies[i] / mid;
        }
        if (count >= k) {
            ans = mid;
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }
    return ans;
}