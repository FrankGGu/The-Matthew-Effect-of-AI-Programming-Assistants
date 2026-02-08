#include <stdio.h>
#include <stdlib.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

int maxSumSubarray(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* minPrefix = (int*)malloc((n + 1) * sizeof(int));
    minPrefix[0] = 0;
    for (int i = 1; i <= n; i++) {
        minPrefix[i] = fmin(minPrefix[i - 1], prefix[i - 1]);
    }

    int maxSum = INT_MIN;
    for (int i = k; i <= n; i++) {
        int currentSum = prefix[i] - minPrefix[i - k];
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    free(prefix);
    free(minPrefix);
    return maxSum;
}

int minSumSubarray(int* nums, int numsSize, int k) {
    int n = numsSize;
    int* prefix = (int*)malloc((n + 1) * sizeof(int));
    for (int i = 0; i < n; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* maxPrefix = (int*)malloc((n + 1) * sizeof(int));
    maxPrefix[0] = 0;
    for (int i = 1; i <= n; i++) {
        maxPrefix[i] = fmax(maxPrefix[i - 1], prefix[i - 1]);
    }

    int minSum = INT_MAX;
    for (int i = k; i <= n; i++) {
        int currentSum = prefix[i] - maxPrefix[i - k];
        if (currentSum < minSum) {
            minSum = currentSum;
        }
    }

    free(prefix);
    free(maxPrefix);
    return minSum;
}

int main() {
    return 0;
}