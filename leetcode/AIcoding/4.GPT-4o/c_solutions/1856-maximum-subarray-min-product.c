#define MOD 1000000007

int maxSumMinProduct(int* nums, int numsSize) {
    long long maxProduct = 0;
    long long* prefixSum = (long long*)malloc((numsSize + 1) * sizeof(long long));
    prefixSum[0] = 0;

    for (int i = 1; i <= numsSize; i++) {
        prefixSum[i] = prefixSum[i - 1] + nums[i - 1];
    }

    long long* stack = (long long*)malloc(numsSize * sizeof(long long));
    int top = -1;

    for (int i = 0; i <= numsSize; i++) {
        while (top != -1 && (i == numsSize || nums[stack[top]] > nums[i])) {
            long long h = nums[stack[top--]];
            long long w = (top == -1) ? i : i - stack[top] - 1;
            maxProduct = fmax(maxProduct, h * (prefixSum[i] - prefixSum[stack[top] + 1]));
        }
        stack[++top] = i;
    }

    free(prefixSum);
    free(stack);

    return maxProduct % MOD;
}