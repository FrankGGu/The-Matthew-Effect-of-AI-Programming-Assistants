typedef struct {
    int *data;
    int *min;
    int top;
    int size;
} MinStack;

MinStack* minStackCreate() {
    MinStack *stack = (MinStack *)malloc(sizeof(MinStack));
    stack->size = 1000;
    stack->data = (int *)malloc(stack->size * sizeof(int));
    stack->min = (int *)malloc(stack->size * sizeof(int));
    stack->top = -1;
    return stack;
}

void minStackPush(MinStack* obj, int val) {
    obj->top++;
    obj->data[obj->top] = val;
    if (obj->top == 0 || val < obj->min[obj->top - 1]) {
        obj->min[obj->top] = val;
    } else {
        obj->min[obj->top] = obj->min[obj->top - 1];
    }
}

void minStackPop(MinStack* obj) {
    if (obj->top >= 0) {
        obj->top--;
    }
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