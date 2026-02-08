#define MOD 1000000007

int totalStrength(int* strength, int strengthSize) {
    long long total = 0;
    long long *prefixSum = (long long *)malloc((strengthSize + 1) * sizeof(long long));
    prefixSum[0] = 0;

    for (int i = 0; i < strengthSize; i++) {
        prefixSum[i + 1] = (prefixSum[i] + strength[i]) % MOD;
    }

    long long *left = (long long *)malloc(strengthSize * sizeof(long long));
    long long *right = (long long *)malloc(strengthSize * sizeof(long long));
    int *stack = (int *)malloc(strengthSize * sizeof(int));

    int top = -1;
    for (int i = 0; i < strengthSize; i++) {
        while (top != -1 && strength[stack[top]] >= strength[i]) {
            top--;
        }
        left[i] = top == -1 ? -1 : stack[top];
        stack[++top] = i;
    }

    top = -1;
    for (int i = strengthSize - 1; i >= 0; i--) {
        while (top != -1 && strength[stack[top]] > strength[i]) {
            top--;
        }
        right[i] = top == -1 ? strengthSize : stack[top];
        stack[++top] = i;
    }

    for (int i = 0; i < strengthSize; i++) {
        long long l = left[i] + 1;
        long long r = right[i];
        long long count = (i - l + 1) * (r - i) % MOD;
        total = (total + strength[i] * count % MOD * (prefixSum[r] - prefixSum[l] + MOD) % MOD) % MOD;
    }

    free(prefixSum);
    free(left);
    free(right);
    free(stack);

    return (int)total;
}