#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmpfunc(const void *a, const const void *b) {
    return (*(int*)a - *(int*)b);
}

int minimumDifference(int* nums, int numsSize) {
    int n = numsSize / 2;
    int totalSum = 0;
    for (int i = 0; i < numsSize; i++) {
        totalSum += nums[i];
    }

    int left[n + 1][1 << n];
    int right[n + 1][1 << n];

    for (int i = 0; i <= n; i++) {
        for (int j = 0; j < (1 << n); j++) {
            left[i][j] = INT_MAX;
            right[i][j] = INT_MAX;
        }
    }

    left[0][0] = 0;
    right[0][0] = 0;

    for (int mask = 0; mask < (1 << n); mask++) {
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) == 0) {
                int count = __builtin_popcount(mask);
                left[count + 1][mask | (1 << i)] = left[count][mask] == INT_MAX ? INT_MAX : left[count][mask] + nums[i];
                left[count][mask | (1 << i)] = left[count][mask] < left[count][mask | (1 << i)] ? left[count][mask] : left[count][mask | (1 << i)];
            }
        }
    }

    for (int mask = 0; mask < (1 << n); mask++) {
        for (int i = 0; i < n; i++) {
            if ((mask & (1 << i)) == 0) {
                int count = __builtin_popcount(mask);
                right[count + 1][mask | (1 << i)] = right[count][mask] == INT_MAX ? INT_MAX : right[count][mask] + nums[n + i];
                right[count][mask | (1 << i)] = right[count][mask] < right[count + 1][mask | (1 << i)] ? right[count][mask] : right[count + 1][mask | (1 << i)];
            }
        }
    }

    int ans = INT_MAX;

    for (int i = 0; i <= n; i++) {
        int leftArrSize = 0;
        for (int j = 0; j < (1 << n); j++) {
            if (left[i][j] != INT_MAX) {
                leftArrSize++;
            }
        }
        int* leftArr = (int*)malloc(leftArrSize * sizeof(int));
        int leftIdx = 0;
        for (int j = 0; j < (1 << n); j++) {
            if (left[i][j] != INT_MAX) {
                leftArr[leftIdx++] = left[i][j];
            }
        }
        qsort(leftArr, leftArrSize, sizeof(int), cmpfunc);

        int rightArrSize = 0;
        for (int j = 0; j < (1 << n); j++) {
            if (right[n - i][j] != INT_MAX) {
                rightArrSize++;
            }
        }
        int* rightArr = (int*)malloc(rightArrSize * sizeof(int));
        int rightIdx = 0;
        for (int j = 0; j < (1 << n); j++) {
            if (right[n - i][j] != INT_MAX) {
                rightArr[rightIdx++] = right[n - i][j];
            }
        }
        qsort(rightArr, rightArrSize, sizeof(int), cmpfunc);

        int l = 0, r = rightArrSize - 1;
        while (l < leftArrSize && r >= 0) {
            int sum = leftArr[l] + rightArr[r];
            ans = abs(totalSum - 2 * sum) < ans ? abs(totalSum - 2 * sum) : ans;

            if (sum * 2 < totalSum) {
                l++;
            } else {
                r--;
            }
        }
        free(leftArr);
        free(rightArr);
    }

    return ans;
}