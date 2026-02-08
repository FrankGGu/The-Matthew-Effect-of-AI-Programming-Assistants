#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int findBestValue(int* arr, int arrSize, int target) {
    qsort(arr, arrSize, sizeof(int), compare);
    int prefixSum[arrSize];
    prefixSum[0] = arr[0];
    for (int i = 1; i < arrSize; i++) {
        prefixSum[i] = prefixSum[i-1] + arr[i];
    }

    int left = 0, right = arr[arrSize-1];
    while (left < right) {
        int mid = (left + right) / 2;
        int sum = 0;
        for (int i = 0; i < arrSize; i++) {
            if (arr[i] > mid) {
                sum += mid;
            } else {
                sum += arr[i];
            }
        }
        if (sum < target) {
            left = mid + 1;
        } else {
            right = mid;
        }
    }

    int best = left;
    int sum = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > best) {
            sum += best;
        } else {
            sum += arr[i];
        }
    }

    if (sum == target) {
        return best;
    }

    int sumLower = 0;
    for (int i = 0; i < arrSize; i++) {
        if (arr[i] > best - 1) {
            sumLower += best - 1;
        } else {
            sumLower += arr[i];
        }
    }

    if (abs(sum - target) < abs(sumLower - target)) {
        return best;
    } else {
        return best - 1;
    }
}