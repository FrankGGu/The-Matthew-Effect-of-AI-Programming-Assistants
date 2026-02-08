#include <stdio.h>
#include <stdlib.h>
#include <math.h>

int minEatingSpeed(int* piles, int pilesSize, int h) {
    int left = 1;
    int right = *max_element(piles, piles + pilesSize);

    while (left < right) {
        int mid = left + (right - left) / 2;
        long hours = 0;
        for (int i = 0; i < pilesSize; i++) {
            hours += ceil((double)piles[i] / mid);
        }
        if (hours > h) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}