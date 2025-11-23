#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *stack;
    int *min_stack;
    int top;
    int capacity;
} MinStack;

MinStack* minStackCreate() {
    MinStack* obj = (MinStack*)malloc(sizeof(MinStack));
    obj->capacity = 10000;
    obj->stack = (int*)malloc(obj->capacity * sizeof(int));
    obj->min_stack = (int*)malloc(obj->capacity * sizeof(int));
    obj->top = -1;
    return obj;
}

void minStackPush(MinStack* obj, int val) {
    obj->top++;
    if (obj->top == obj->capacity) {
        obj->capacity *= 2;
        obj->stack = (int*)realloc(obj->stack, obj->capacity * sizeof(int));
        obj->min_stack = (int*)realloc(obj->min_stack, obj->capacity * sizeof(int));
    }
    obj->stack[obj->top] = val;
    if (obj->top == 0) {
        obj->min_stack[obj->top] = val;
    } else {
        obj->min_stack[obj->top] = (val < obj->min_stack[obj->top - 1]) ? val : obj->min_stack[obj->top - 1];
    }
}

void minStackPop(MinStack* obj) {
    if (obj->top >= 0) {
        obj->top--;
    }
}

int minStackTop(MinStack* obj) {
    if (obj->top >= 0) {
        return obj->stack[obj->top];
    }
    return -1;
}

int minStackGetMin(MinStack* obj) {
    if (obj->top >= 0) {
        return obj->min_stack[obj->top];
    }
    return -1;
}

void minStackFree(MinStack* obj) {
    free(obj->stack);
    free(obj->min_stack);
    free(obj);
}