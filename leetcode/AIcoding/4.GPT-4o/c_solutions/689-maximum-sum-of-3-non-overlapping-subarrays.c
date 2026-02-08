int maxSumOfThreeSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    int* sum = (int*)malloc((numsSize + 1) * sizeof(int));
    int n = numsSize;
    int maxSum = 0;
    int bestCombo[3] = {0, 0, 0};
    *returnSize = 3;

    for (int i = 1; i <= n; i++) {
        sum[i] = sum[i - 1] + (i >= k ? nums[i - 1] : 0);
        if (i >= k) {
            sum[i] -= sum[i - k];
        }
    }

    int* leftMax = (int*)malloc((n + 1) * sizeof(int));
    int* rightMax = (int*)malloc((n + 1) * sizeof(int));

    for (int i = k, maxIndex = 0; i <= n; i++) {
        if (sum[i] > sum[maxIndex]) {
            maxIndex = i;
        }
        leftMax[i] = maxIndex;
    }

    for (int i = n - k, maxIndex = n; i >= 0; i--) {
        if (sum[i] >= sum[maxIndex]) {
            maxIndex = i;
        }
        rightMax[i] = maxIndex;
    }

    for (int j = k; j <= n - 2 * k; j++) {
        int i = leftMax[j - k];
        int m = rightMax[j + k];
        int total = sum[i] + sum[j] + sum[m];
        if (total > maxSum) {
            maxSum = total;
            bestCombo[0] = i - k;
            bestCombo[1] = j - k;
            bestCombo[2] = m - k;
        }
    }

    free(sum);
    free(leftMax);
    free(rightMax);
    return bestCombo;
}