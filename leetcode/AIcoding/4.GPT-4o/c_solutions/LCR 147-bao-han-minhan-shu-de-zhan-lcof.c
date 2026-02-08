typedef struct {
    int *data;
    int *min;
    int top;
} MinStack;

MinStack* minStackCreate() {
    MinStack *stack = (MinStack *)malloc(sizeof(MinStack));
    stack->data = (int *)malloc(1000 * sizeof(int));
    stack->min = (int *)malloc(1000 * sizeof(int));
    stack->top = -1;
    return stack;
}

void minStackPush(MinStack* obj, int x) {
    obj->data[++(obj->top)] = x;
    if (obj->top == 0 || x < obj->min[obj->top - 1]) {
        obj->min[obj->top] = x;
    } else {
        obj->min[obj->top] = obj->min[obj->top - 1];
    }
}

void minStackPop(MinStack* obj) {
    obj->top--;
}

int minStackTop(MinStack* obj) {
    return obj->data[obj->top];
}

int minStackGetMin(MinStack* obj) {
    return obj->min[obj->top];
}

void minStackFree(MinStack* obj) {
    free(obj->data);
    free(obj->min);
    free(obj);
}