int sumSubarrayMins(int* arr, int arrSize) {
    int MOD = 1000000007;
    long long sum = 0;
    int *stack = (int*)malloc((arrSize + 1) * sizeof(int));
    int *prev = (int*)malloc(arrSize * sizeof(int));
    int *next = (int*)malloc(arrSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < arrSize; i++) {
        prev[i] = -1;
        next[i] = arrSize;
    }

    for (int i = 0; i < arrSize; i++) {
        while (top >= 0 && arr[stack[top]] >= arr[i]) {
            next[stack[top]] = i;
            top--;
        }
        if (top >= 0) {
            prev[i] = stack[top];
        }
        stack[++top] = i;
    }

    for (int i = 0; i < arrSize; i++) {
        long long left = i - prev[i];
        long long right = next[i] - i;
        sum = (sum + left * right % MOD * arr[i] % MOD) % MOD;
    }

    free(stack);
    free(prev);
    free(next);
    return sum;
}