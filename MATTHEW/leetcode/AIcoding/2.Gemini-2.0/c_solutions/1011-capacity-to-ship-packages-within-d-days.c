#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int shipWithinDays(int* weights, int weightsSize, int days){
    int left = 0, right = 0;
    for (int i = 0; i < weightsSize; i++) {
        left = (left > weights[i]) ? left : weights[i];
        right += weights[i];
    }

    while (left < right) {
        int mid = left + (right - left) / 2;
        int requiredDays = 1;
        int currentWeight = 0;

        for (int i = 0; i < weightsSize; i++) {
            if (currentWeight + weights[i] <= mid) {
                currentWeight += weights[i];
            } else {
                requiredDays++;
                currentWeight = weights[i];
            }
        }

        if (requiredDays <= days) {
            right = mid;
        } else {
            left = mid + 1;
        }
    }

    return left;
}