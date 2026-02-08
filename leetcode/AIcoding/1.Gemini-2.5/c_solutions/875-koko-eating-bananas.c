#include <stdbool.h>

bool check(int* piles, int pilesSize, long long k, int h) {
    long long hoursNeeded = 0;
    for (int i = 0; i < pilesSize; i++) {
        hoursNeeded += (piles[i] + k - 1) / k;
        if (hoursNeeded > h) {
            return false;
        }
    }
    return true;
}

int minEatingSpeed(int* piles, int pilesSize, int h) {
    long long low = 1;
    long long high = 0; 
    for (int i = 0; i < pilesSize; i++) {
        if (piles[i] > high) {
            high = piles[i];
        }
    }

    long long ans = high; 

    while (low <= high) {
        long long mid = low + (high - low) / 2;

        if (check(piles, pilesSize, mid, h)) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return (int)ans;
}