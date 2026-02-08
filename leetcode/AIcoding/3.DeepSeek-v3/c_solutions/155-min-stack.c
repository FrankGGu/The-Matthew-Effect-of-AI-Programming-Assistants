typedef struct {
    int *data;
    int *min;
    int top;
    int capacity;
} MinStack;

MinStack* minStackCreate() {
    MinStack *obj = (MinStack*)malloc(sizeof(MinStack));
    obj->capacity = 10000;
    obj->data = (int*)malloc(obj->capacity * sizeof(int));
    obj->min = (int*)malloc(obj->capacity * sizeof(int));
    obj->top = -1;
    return obj;
}

void minStackPush(MinStack* obj, int val) {
    if (obj->top == obj->capacity - 1) return;
    obj->top++;
    obj->data[obj->top] = val;
    if (obj->top == 0) {
        obj->min[obj->top] = val;
    } else {
        obj->min[obj->top] = (val < obj->min[obj->top - 1]) ? val : obj->min[obj->top - 1];
    }
}

void minStackPop(MinStack* obj) {
    if (obj->top == -1) return;
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