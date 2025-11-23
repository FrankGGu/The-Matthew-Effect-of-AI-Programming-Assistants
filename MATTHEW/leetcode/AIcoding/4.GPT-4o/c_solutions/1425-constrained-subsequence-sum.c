int max(int a, int b) {
    return a > b ? a : b;
}

int constrainedSubsetSum(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    int* deque = (int*)malloc(numsSize * sizeof(int));
    int front = 0, rear = 0;

    dp[0] = nums[0];
    deque[rear++] = 0;

    for (int i = 1; i < numsSize; i++) {
        while (front < rear && deque[front] < i - k) {
            front++;
        }
        dp[i] = max(nums[i], dp[deque[front]] + nums[i]);

        while (front < rear && dp[deque[rear - 1]] <= dp[i]) {
            rear--;
        }
        deque[rear++] = i;
    }

    int result = dp[0];
    for (int i = 1; i < numsSize; i++) {
        result = max(result, dp[i]);
    }

    free(dp);
    free(deque);

    return result;
}