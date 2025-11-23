/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxSumOfThreeSubarrays(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = 3;
    int* result = (int*)malloc(3 * sizeof(int));

    int* sum = (int*)malloc((numsSize - k + 1) * sizeof(int));
    int s = 0;
    for (int i = 0; i < k; i++) {
        s += nums[i];
    }
    sum[0] = s;
    for (int i = 1; i <= numsSize - k; i++) {
        s = s - nums[i - 1] + nums[i + k - 1];
        sum[i] = s;
    }

    int* left = (int*)malloc((numsSize - k + 1) * sizeof(int));
    int best = 0;
    for (int i = 0; i <= numsSize - k; i++) {
        if (sum[i] > sum[best]) {
            best = i;
        }
        left[i] = best;
    }

    int* right = (int*)malloc((numsSize - k + 1) * sizeof(int));
    best = numsSize - k;
    for (int i = numsSize - k; i >= 0; i--) {
        if (sum[i] >= sum[best]) {
            best = i;
        }
        right[i] = best;
    }

    int maxSum = 0;
    for (int j = k; j <= numsSize - 2 * k; j++) {
        int i = left[j - k];
        int l = right[j + k];
        int total = sum[i] + sum[j] + sum[l];
        if (total > maxSum) {
            maxSum = total;
            result[0] = i;
            result[1] = j;
            result[2] = l;
        }
    }

    free(sum);
    free(left);
    free(right);

    return result;
}