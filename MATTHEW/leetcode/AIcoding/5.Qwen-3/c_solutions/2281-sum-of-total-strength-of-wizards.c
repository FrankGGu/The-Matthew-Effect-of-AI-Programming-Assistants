#include <stdio.h>
#include <stdlib.h>

long long* getStronger(int* strength, int strengthSize, int* returnSize) {
    *returnSize = 0;
    if (strengthSize == 0) return NULL;

    long long* result = (long long*)malloc(strengthSize * sizeof(long long));
    long long* prefix = (long long*)malloc((strengthSize + 1) * sizeof(long long));
    long long* suffix = (stack_t*)malloc((strengthSize + 1) * sizeof(long long));

    for (int i = 0; i < strengthSize; i++) {
        prefix[i + 1] = prefix[i] + strength[i];
    }

    for (int i = strengthSize - 1; i >= 0; i--) {
        suffix[i] = suffix[i + 1] + strength[i];
    }

    int* left = (int*)malloc(strengthSize * sizeof(int));
    int* right = (int*)malloc(strengthSize * sizeof(int));
    int* stack = (int*)malloc(strengthSize * sizeof(int));
    int top = -1;

    for (int i = 0; i < strengthSize; i++) {
        while (top >= 0 && strength[stack[top]] <= strength[i]) top--;
        left[i] = (top >= 0) ? stack[top] : -1;
        stack[++top] = i;
    }

    top = -1;
    for (int i = strengthSize - 1; i >= 0; i--) {
        while (top >= 0 && strength[stack[top]] < strength[i]) top--;
        right[i] = (top >= 0) ? stack[top] : strengthSize;
        stack[++top] = i;
    }

    for (int i = 0; i < strengthSize; i++) {
        int l = left[i];
        int r = right[i];
        long long sumLeft = prefix[i] - prefix[l + 1];
        long long sumRight = suffix[i] - suffix[r];
        long long total = (sumLeft * (i - l) + sumRight * (r - i)) * strength[i];
        result[*returnSize] = total;
        (*returnSize)++;
    }

    free(prefix);
    free(suffix);
    free(left);
    free(right);
    free(stack);
    return result;
}