#include <stdio.h>
#include <stdlib.h>

int sumSubarrayMins(int* arr, int arrSize) {
    int MOD = 1000000007;
    int n = arrSize;
    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; ++i) {
        while (top >= 0 && arr[stack[top]] > arr[i]) {
            --top;
        }
        left[i] = (top >= 0) ? stack[top] : -1;
        stack[++top] = i;
    }

    top = -1;
    for (int i = n - 1; i >= 0; --i) {
        while (top >= 0 && arr[stack[top]] >= arr[i]) {
            --top;
        }
        right[i] = (top >= 0) ? stack[top] : n;
        stack[++top] = i;
    }

    long long res = 0;
    for (int i = 0; i < n; ++i) {
        res += (long long)(i - left[i]) * (right[i] - i) * arr[i];
        res %= MOD;
    }

    free(left);
    free(right);
    free(stack);

    return (int)res;
}