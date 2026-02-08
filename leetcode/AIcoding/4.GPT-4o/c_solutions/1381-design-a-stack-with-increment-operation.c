typedef struct {
    int *stack;
    int top;
    int capacity;
} CustomStack;

CustomStack* customStackCreate(int maxSize) {
    CustomStack *stack = (CustomStack *)malloc(sizeof(CustomStack));
    stack->stack = (int *)malloc(maxSize * sizeof(int));
    stack->top = -1;
    stack->capacity = maxSize;
    return stack;
}

void customStackPush(CustomStack* obj, int x) {
    if (obj->top < obj->capacity - 1) {
        obj->stack[++obj->top] = x;
    }
}

int customStackPop(CustomStack* obj) {
    if (obj->top == -1) {
        return -1;
    }
    return obj->stack[obj->top--];
}

void customStackIncrement(CustomStack* obj, int k, int val) {
    int limit = k < obj->top + 1 ? k : obj->top + 1;
    for (int i = 0; i < limit; i++) {
        obj->stack[i] += val;
    }
}

void customStackFree(CustomStack* obj) {
    free(obj->stack);
    free(obj);
}