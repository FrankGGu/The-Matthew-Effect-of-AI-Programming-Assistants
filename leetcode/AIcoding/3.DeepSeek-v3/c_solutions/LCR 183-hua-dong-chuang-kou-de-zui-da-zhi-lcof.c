/**
 * Note: The returned array must be malloced, assume caller calls free().
 */
int* maxAltitude(int* height, int heightSize, int k, int* returnSize) {
    *returnSize = heightSize - k + 1;
    int* result = (int*)malloc(*returnSize * sizeof(int));
    int* deque = (int*)malloc(heightSize * sizeof(int));
    int front = 0, rear = -1;

    for (int i = 0; i < heightSize; i++) {
        while (rear >= front && height[deque[rear]] <= height[i]) {
            rear--;
        }
        deque[++rear] = i;

        if (deque[front] <= i - k) {
            front++;
        }

        if (i >= k - 1) {
            result[i - k + 1] = height[deque[front]];
        }
    }

    free(deque);
    return result;
}