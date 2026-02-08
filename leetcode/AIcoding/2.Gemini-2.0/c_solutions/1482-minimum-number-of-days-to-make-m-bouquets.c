#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minDays(int* bloomDay, int bloomSize, int m, int k) {
    if ((long long)m * k > bloomSize) {
        return -1;
    }

    int left = 1;
    int right = 1;
    for (int i = 0; i < bloomSize; i++) {
        if (bloomDay[i] > right) {
            right = bloomDay[i];
        }
    }

    int ans = -1;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        int bouquets = 0;
        int flowers = 0;
        for (int i = 0; i < bloomSize; i++) {
            if (bloomDay[i] <= mid) {
                flowers++;
                if (flowers == k) {
                    bouquets++;
                    flowers = 0;
                }
            } else {
                flowers = 0;
            }
        }

        if (bouquets >= m) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return ans;
}