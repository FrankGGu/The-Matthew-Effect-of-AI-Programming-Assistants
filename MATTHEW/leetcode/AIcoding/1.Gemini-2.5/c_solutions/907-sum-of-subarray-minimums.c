#include <stdlib.h>

#define MOD 1000000007

typedef struct {
    int val;
    int idx;
} StackNode;

int sumSubarrayMins(int* arr, int arrSize) {
    if (arrSize == 0) {
        return 0;
    }

    int* left = (int*)malloc(arrSize * sizeof(int));
    int* right = (int*)malloc(arrSize * sizeof(int));

    StackNode* stack = (StackNode*)malloc((arrSize + 1) * sizeof(StackNode));
    int stackTop = -1;

    for (int i = 0; i < arrSize; ++i) {
        while (stackTop != -1 && stack[stackTop].val >= arr[i]) {
            stackTop--;
        }
        left[i] = i - (stackTop == -1 ? -1 : stack[stackTop].idx);
        stackTop++;
        stack[stackTop].val = arr[i];
        stack[stackTop].idx = i;
    }

    stackTop = -1;

    for (int i = arrSize - 1; i >= 0; --i) {
        while (stackTop != -1 && stack[stackTop].val > arr[i]) {
            stackTop--;
        }
        right[i] = (stackTop == -1 ? arrSize : stack[stackTop].idx) - i;
        stackTop++;
        stack[stackTop].val = arr[i];
        stack[stackTop].idx = i;
    }

    long long totalSum = 0;
    for (int i = 0; i < arrSize; ++i) {
        totalSum = (totalSum + (long long)arr[i] * left[i] * right[i]) % MOD;
    }

    free(left);
    free(right);
    free(stack);

    return (int)totalSum;
}