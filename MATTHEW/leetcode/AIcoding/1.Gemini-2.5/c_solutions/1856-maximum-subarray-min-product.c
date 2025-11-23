#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* arr;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    if (stack == NULL) return NULL;
    stack->capacity = capacity;
    stack->top = -1;
    stack->arr = (int*)malloc(stack->capacity * sizeof(int));
    if (stack->arr == NULL) {
        free(stack);
        return NULL;
    }
    return stack;
}

void push(Stack* stack, int item) {
    stack->arr[++stack->top] = item;
}

int pop(Stack* stack) {
    return stack->arr[stack->top--];
}

int peek(Stack* stack) {
    return stack->arr[stack->top];
}

int isEmpty(Stack* stack) {
    return stack->top == -1;
}

void freeStack(Stack* stack) {
    if (stack == NULL) return;
    free(stack->arr);
    free(stack);
}

long long maxSumMinProduct(int* nums, int numsSize) {
    long long* prefixSum = (long long*)malloc((numsSize + 1) * sizeof(long long));
    if (prefixSum == NULL) return 0;
    prefixSum[0] = 0;
    for (int i = 0; i < numsSize; i++) {
        prefixSum[i + 1] = prefixSum[i] + nums[i];
    }

    int* left = (int*)malloc(numsSize * sizeof(int));
    int* right = (int*)malloc(numsSize * sizeof(int));
    if (left == NULL || right == NULL) {
        free(prefixSum);
        free(left);
        free(right);
        return 0;
    }

    Stack* stack = createStack(numsSize);
    if (stack == NULL) {
        free(prefixSum);
        free(left);
        free(right);
        return 0;
    }

    for (int i = 0; i < numsSize; i++) {
        while (!isEmpty(stack) && nums[peek(stack)] >= nums[i]) {
            pop(stack);
        }
        left[i] = isEmpty(stack) ? -1 : peek(stack);
        push(stack, i);
    }

    stack->top = -1; 

    for (int i = numsSize - 1; i >= 0; i--) {
        while (!isEmpty(stack) && nums[peek(stack)] >= nums[i]) {
            pop(stack);
        }
        right[i] = isEmpty(stack) ? numsSize : peek(stack);
        push(stack, i);
    }

    freeStack(stack);

    long long maxProduct = 0; 

    for (int i = 0; i < numsSize; i++) {
        int start_idx = left[i] + 1;
        int end_idx = right[i] - 1;

        long long currentSum = prefixSum[end_idx + 1] - prefixSum[start_idx];
        long long currentProduct = (long long)nums[i] * currentSum;

        if (currentProduct > maxProduct) {
            maxProduct = currentProduct;
        }
    }

    free(prefixSum);
    free(left);
    free(right);

    long long MOD = 1e9 + 7;
    return maxProduct % MOD;
}