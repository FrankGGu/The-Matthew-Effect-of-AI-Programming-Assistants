#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int canEatAll(int piles[], int pilesSize, int h, int k) {
    long long time = 0;
    for (int i = 0; i < pilesSize; i++) {
        time += (piles[i] + k - 1) / k;
    }
    return time <= h;
}

int minEatingSpeed(int piles[], int pilesSize, int h) {
    int left = 1;
    int right = 0;
    for (int i = 0; i < pilesSize; i++) {
        if (piles[i] > right) {
            right = piles[i];
        }
    }

    int ans = right;
    while (left <= right) {
        int mid = left + (right - left) / 2;
        if (canEatAll(piles, pilesSize, h, mid)) {
            ans = mid;
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }
    return ans;
}