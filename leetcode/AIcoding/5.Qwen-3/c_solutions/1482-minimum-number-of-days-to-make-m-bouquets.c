#include <stdio.h>
#include <stdlib.h>

int minDays(int* bloomDay, int bloomDaySize, int m, int n) {
    if (m * n > bloomDaySize) return -1;

    int left = 1, right = 0;
    for (int i = 0; i < bloomDaySize; i++) {
        if (bloomDay[i] > right) right = bloomDay[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = 0;
        int consecutive = 0;

        for (int i = 0; i < bloomDaySize; i++) {
            if (bloomDay[i] <= mid) {
                consecutive++;
                if (consecutive == n) {
                    count++;
                    consecutive = 0;
                }
            } else {
                consecutive = 0;
            }
        }

        if (count >= m) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}