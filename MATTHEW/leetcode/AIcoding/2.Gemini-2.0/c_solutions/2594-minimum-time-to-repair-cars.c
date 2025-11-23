#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long minimumTime(int* ranks, int ranksSize, int cars) {
    long long left = 0, right = 1e14;
    long long ans = right;
    while (left <= right) {
        long long mid = left + (right - left) / 2;
        long long repaired = 0;
        for (int i = 0; i < ranksSize; i++) {
            repaired += (long long)sqrt((double)mid / ranks[i]);
        }
        if (repaired >= cars) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}