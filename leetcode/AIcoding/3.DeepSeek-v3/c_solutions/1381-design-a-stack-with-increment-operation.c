typedef struct {
    int *stack;
    int top;
    int maxSize;
} CustomStack;

CustomStack* customStackCreate(int maxSize) {
    CustomStack *obj = (CustomStack*)malloc(sizeof(CustomStack));
    obj->stack = (int*)malloc(sizeof(int) * maxSize);
    obj->top = -1;
    obj->maxSize = maxSize;
    return obj;
}

void customStackPush(CustomStack* obj, int x) {
    if (obj->top < obj->maxSize - 1) {
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