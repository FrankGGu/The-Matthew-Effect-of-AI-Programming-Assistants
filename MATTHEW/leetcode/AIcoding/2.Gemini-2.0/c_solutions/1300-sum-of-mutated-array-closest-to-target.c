#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int findBestValue(int* arr, int arrSize, int target) {
    int left = 0, right = 0;
    int sum = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > right) {
            right = arr[i];
        }
        sum += arr[i];
    }

    if (sum <= target) {
        return right;
    }

    int bestValue = 0;
    int minDiff = INT_MAX;

    while (left <= right) {
        int mid = left + (right - left) / 2;
        int currentSum = 0;
        for (int i = 0; i < arrSize; i++) {
            currentSum += (arr[i] <= mid) ? arr[i] : mid;
        }

        int diff = abs(currentSum - target);
        if (diff < minDiff) {
            minDiff = diff;
            bestValue = mid;
        } else if (diff == minDiff && mid < bestValue) {
            bestValue = mid;
        }

        if (currentSum > target) {
            right = mid - 1;
        } else {
            left = mid + 1;
        }
    }

    return bestValue;
}