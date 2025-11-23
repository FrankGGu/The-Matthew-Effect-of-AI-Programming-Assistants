int maxResult(int* nums, int numsSize, int k) {
    int* dp = (int*)malloc(numsSize * sizeof(int));
    dp[0] = nums[0];
    int maxDeque[numsSize];
    int front = 0, rear = 0;
    maxDeque[rear++] = 0;

    for (int i = 1; i < numsSize; i++) {
        while (front < rear && maxDeque[front] < i - k) {
            front++;
        }
        dp[i] = nums[i] + dp[maxDeque[front]];
        while (front < rear && dp[maxDeque[rear - 1]] <= dp[i]) {
            rear--;
        }
        maxDeque[rear++] = i;
    }

    int result = dp[numsSize - 1];
    free(dp);
    return result;
}