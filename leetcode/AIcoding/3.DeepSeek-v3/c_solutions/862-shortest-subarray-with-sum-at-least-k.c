typedef long long ll;

int shortestSubarray(int* nums, int numsSize, int k) {
    ll* prefix = (ll*)malloc((numsSize + 1) * sizeof(ll));
    prefix[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefix[i + 1] = prefix[i] + nums[i];
    }

    int* deque = (int*)malloc((numsSize + 1) * sizeof(int));
    int front = 0, rear = 0;
    int minLen = numsSize + 1;

    for (int i = 0; i <= numsSize; i++) {
        while (front < rear && prefix[i] - prefix[deque[front]] >= k) {
            int len = i - deque[front];
            if (len < minLen) minLen = len;
            front++;
        }

        while (front < rear && prefix[i] <= prefix[deque[rear - 1]]) {
            rear--;
        }

        deque[rear++] = i;
    }

    free(prefix);
    free(deque);

    return minLen == numsSize + 1 ? -1 : minLen;
}