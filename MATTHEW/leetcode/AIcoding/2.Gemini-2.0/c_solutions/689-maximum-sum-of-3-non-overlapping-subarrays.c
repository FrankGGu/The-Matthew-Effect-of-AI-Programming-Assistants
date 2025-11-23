#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int* maxSumOfThreeSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    int* w = (int*)malloc(sizeof(int) * (numsSize - k + 1));
    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += nums[i];
    }
    w[0] = sum;
    for (int i = k; i < numsSize; i++) {
        sum = sum - nums[i - k] + nums[i];
        w[i - k + 1] = sum;
    }

    int n = numsSize - k + 1;
    int* left = (int*)malloc(sizeof(int) * n);
    int* right = (int*)malloc(sizeof(int) * n);
    left[0] = 0;
    for (int i = 1; i < n; i++) {
        if (w[i] > w[left[i - 1]]) {
            left[i] = i;
        } else {
            left[i] = left[i - 1];
        }
    }
    right[n - 1] = n - 1;
    for (int i = n - 2; i >= 0; i--) {
        if (w[i] >= w[right[i + 1]]) {
            right[i] = i;
        } else {
            right[i] = right[i + 1];
        }
    }

    int* ans = (int*)malloc(sizeof(int) * 3);
    int maxSum = 0;
    for (int j = k; j < n - k; j++) {
        int l = left[j - k];
        int r = right[j + k];
        int currentSum = w[l] + w[j] + w[r];
        if (currentSum > maxSum) {
            maxSum = currentSum;
            ans[0] = l;
            ans[1] = j;
            ans[2] = r;
        }
    }

    free(w);
    free(left);
    free(right);

    *returnSize = 3;
    return ans;
}