#include <stdio.h>
#include <stdlib.h>

int shipWithinDays(int* weights, int weightsSize, int D) {
    int left = 0, right = 0;
    for (int i = 0; i < weightsSize; i++) {
        left = fmax(left, weights[i]);
        right += weights[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int count = 1, current = 0;
        for (int i = 0; i < weightsSize; i++) {
            if (current + weights[i] > mid) {
                count++;
                current = 0;
            }
            current += weights[i];
        }
        if (count > D) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }
    return left;
}