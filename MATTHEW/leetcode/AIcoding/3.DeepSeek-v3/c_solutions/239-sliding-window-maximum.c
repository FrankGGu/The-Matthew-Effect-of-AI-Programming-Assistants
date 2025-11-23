/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    if (numsSize == 0) {
        *returnSize = 0;
        return NULL;
    }

    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    int* deque = (int*)malloc(numsSize * sizeof(int));
    int front = 0, rear = -1;

    for (int i = 0; i < numsSize; i++) {
        while (rear >= front && nums[i] >= nums[deque[rear]]) {
            rear--;
        }
        deque[++rear] = i;

        if (deque[front] <= i - k) {
            front++;
        }

        if (i >= k - 1) {
            result[i - k + 1] = nums[deque[front]];
        }
    }

    free(deque);
    return result;
}