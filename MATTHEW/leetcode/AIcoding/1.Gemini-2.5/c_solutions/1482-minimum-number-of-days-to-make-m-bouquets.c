#include <stdbool.h>

bool canMakeBouquets(int day, int* bloomDay, int bloomDaySize, int m, int k) {
    int bouquets = 0;
    int consecutive_flowers = 0;
    for (int i = 0; i < bloomDaySize; i++) {
        if (bloomDay[i] <= day) {
            consecutive_flowers++;
            if (consecutive_flowers == k) {
                bouquets++;
                consecutive_flowers = 0;
            }
        } else {
            consecutive_flowers = 0;
        }
        if (bouquets >= m) {
            return true;
        }
    }
    return bouquets >= m;
}

int minDays(int* bloomDay, int bloomDaySize, int m, int k) {
    if ((long long)m * k > bloomDaySize) {
        return -1;
    }

    int low = 1;
    int high = 1000000000; 
    int ans = -1;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (canMakeBouquets(mid, bloomDay, bloomDaySize, m, k)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}