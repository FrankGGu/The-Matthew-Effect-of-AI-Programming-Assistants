#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findBestValue(int* arr, int arrSize, int target) {
    int left = 0, right = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > right) {
            right = arr[i];
        }
    }

    int bestValue = -1;
    int minDiff = INT_MAX;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int sum = 0;
        for (int i = 0; i < arrSize; i++) {
            sum += (arr[i] > mid) ? mid : arr[i];
        }

        int diff = abs(sum - target);
        if (diff < minDiff) {
            minDiff = diff;
            bestValue = mid;
        } else if (diff == minDiff && mid < bestValue) {
            bestValue = mid;
        }

        if (sum < target) {
            left = mid + 1;
        } else {
            right = mid - 1;
        }
    }

    return bestValue;
}