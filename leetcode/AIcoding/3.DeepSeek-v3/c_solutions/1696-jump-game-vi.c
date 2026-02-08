typedef struct {
    int index;
    int val;
} Node;

int maxResult(int* nums, int numsSize, int k) {
    if (numsSize == 1) return nums[0];

    int* dp = (int*)malloc(numsSize * sizeof(int));
    dp[0] = nums[0];

    Node* deque = (Node*)malloc(numsSize * sizeof(Node));
    int front = 0, rear = 0;
    deque[rear].index = 0;
    deque[rear].val = dp[0];
    rear++;

    for (int i = 1; i < numsSize; i++) {
        while (front < rear && deque[front].index < i - k) {
            front++;
        }

        dp[i] = deque[front].val + nums[i];

        while (front < rear && deque[rear - 1].val < dp[i]) {
            rear--;
        }

        deque[rear].index = i;
        deque[rear].val = dp[i];
        rear++;
    }

    int result = dp[numsSize - 1];
    free(dp);
    free(deque);
    return result;
}