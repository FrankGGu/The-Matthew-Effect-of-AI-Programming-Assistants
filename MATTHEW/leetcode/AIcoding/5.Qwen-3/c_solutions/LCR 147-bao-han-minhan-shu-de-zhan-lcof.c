#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *stack;
    int *min_stack;
    int top;
    int capacity;
} MinStack;

MinStack* minStackCreate() {
    MinStack *obj = (MinStack*)malloc(sizeof(MinStack));
    obj->capacity = 10;
    obj->stack = (int*)malloc(obj->capacity * sizeof(int));
    obj->min_stack = (int*)malloc(obj->capacity * sizeof(int));
    obj->top = -1;
    return obj;
}

void minStackPush(MinStack* obj, int val) {
    if (obj->top == obj->capacity - 1) {
        obj->capacity *= 2;
        obj->stack = (int*)realloc(obj->stack, obj->capacity * sizeof(int));
        obj->min_stack = (int*)realloc(obj->min_stack, obj->capacity * sizeof(int));
    }
    obj->top++;
    obj->stack[obj->top] = val;
    if (obj->top == 0 || val < obj->min_stack[obj->top - 1]) {
        obj->min_stack[obj->top] = val;
    } else {
        obj->min_stack[obj->top] = obj->min_stack[obj->top - 1];
    }
}

void minStackPop(MinStack* obj) {
    obj->top--;
}

int minStackTop(MinStack* obj) {
    return obj->stack[obj->top];
}

int minStackGetMin(MinStack* obj) {
    return obj->min_stack[obj->top];
}

void minStackFree(MinStack* obj) {
    free(obj->stack);
    free(obj->min_stack);
    free(obj);
}