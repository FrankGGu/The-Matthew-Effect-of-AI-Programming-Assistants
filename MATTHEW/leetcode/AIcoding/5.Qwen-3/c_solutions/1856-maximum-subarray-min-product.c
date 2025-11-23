#include <stdio.h>
#include <stdlib.h>

long long maxSubarrayMinProduct(int* nums, int numsSize) {
    int n = numsSize;
    long long result = 0;

    int* left = (int*)malloc(n * sizeof(int));
    int* right = (int*)malloc(n * sizeof(int));

    int* stack = (int*)malloc(n * sizeof(int));
    int top = -1;

    for (int i = 0; i < n; ++i) {
        while (top >= 0 && nums[stack[top]] >= nums[i]) {
            --top;
        }
        left[i] = (top >= 0) ? stack[top] : -1;
        stack[++top] = i;
    }

    top = -1;
    for (int i = n - 1; i >= 0; --i) {
        while (top >= 0 && nums[stack[top]] >= nums[i]) {
            --top;
        }
        right[i] = (top >= 0) ? stack[top] : n;
        stack[++top] = i;
    }

    for (int i = 0; i < n; ++i) {
        long long minVal = nums[i];
        long long sum = 0;
        for (int j = left[i] + 1; j <= right[i] - 1; ++j) {
            sum += nums[j];
        }
        result = (result > minVal * sum) ? result : minVal * sum;
    }

    free(left);
    free(right);
    free(stack);

    return result;
}