bool find132pattern(int* nums, int numsSize) {
    if (numsSize < 3) return false;

    int* min = (int*)malloc(numsSize * sizeof(int));
    min[0] = nums[0];

    for (int i = 1; i < numsSize; i++) {
        min[i] = fmin(min[i - 1], nums[i]);
    }

    struct Stack {
        int* arr;
        int top;
        int size;
    };

    struct Stack* stack = (struct Stack*)malloc(sizeof(struct Stack));
    stack->size = numsSize;
    stack->top = -1;
    stack->arr = (int*)malloc(stack->size * sizeof(int));

    for (int j = numsSize - 1; j >= 0; j--) {
        while (stack->top != -1 && nums[j] > stack->arr[stack->top]) {
            if (min[j] < stack->arr[stack->top]) {
                free(min);
                free(stack->arr);
                free(stack);
                return true;
            }
            stack->top--;
        }
        stack->arr[++stack->top] = nums[j];
    }

    free(min);
    free(stack->arr);
    free(stack);
    return false;
}