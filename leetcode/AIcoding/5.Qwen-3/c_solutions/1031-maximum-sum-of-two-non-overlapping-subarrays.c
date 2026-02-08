#include <stdio.h>
#include <stdlib.h>

int max(int a, int b) {
    return a > b ? a : b;
}

int maxSumTwoNoOverlap(int* nums, int numsSize, int l, int m) {
    int n = numsSize;
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));
    int* dp = (int*)malloc(n * sizeof(int));

    int sum = 0;
    for (int i = 0; i < l; i++) {
        sum += nums[i];
    }
    left[0] = sum;
    for (int i = l; i < n; i++) {
        sum += nums[i] - nums[i - l];
        left[i - l + 1] = max(left[i - l], sum);
    }

    sum = 0;
    for (int i = 0; i < m; i++) {
        sum += nums[i];
    }
    right[0] = sum;
    for (int i = m; i < n; i++) {
        sum += nums[i] - nums[i - m];
        right[i - m + 1] = max(right[i - m], sum);
    }

    int res = 0;
    for (int i = 0; i < n; i++) {
        if (i + l <= n) {
            int curr = left[i];
            if (i + l < n) {
                curr += right[i + l];
            }
            res = max(res, curr);
        }
        if (i + m <= n) {
            int curr = right[i];
            if (i + m < n) {
                curr += left[i + m];
            }
            res = max(res, curr);
        }
    }

    free(left);
    free(right);
    free(dp);
    return res;
}