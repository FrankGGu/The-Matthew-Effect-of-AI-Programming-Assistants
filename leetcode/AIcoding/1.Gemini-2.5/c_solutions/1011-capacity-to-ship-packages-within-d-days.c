#include <stdbool.h>

bool canShip(int capacity, int* packages, int packagesSize, int D) {
    int days = 1;
    int currentWeight = 0;
    for (int i = 0; i < packagesSize; i++) {
        if (currentWeight + packages[i] > capacity) {
            days++;
            currentWeight = packages[i];
        } else {
            currentWeight += packages[i];
        }
    }
    return days <= D;
}

int shipWithinDays(int* packages, int packagesSize, int D) {
    int low = 0;
    int high = 0;

    for (int i = 0; i < packagesSize; i++) {
        if (packages[i] > low) {
            low = packages[i];
        }
        high += packages[i];
    }

    int ans = high;

    while (low <= high) {
        int mid = low + (high - low) / 2;
        if (canShip(mid, packages, packagesSize, D)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
}