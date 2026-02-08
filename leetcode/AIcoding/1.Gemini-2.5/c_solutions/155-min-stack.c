#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* stack;
    int* min_stack;
    int top;
    int capacity;
} MinStack;

MinStack* minStackCreate() {
    MinStack* obj = (MinStack*)malloc(sizeof(MinStack));
    obj->capacity = 10000; // Initial capacity, can be dynamic
    obj->stack = (int*)malloc(sizeof(int) * obj->capacity);
    obj->min_stack = (int*)malloc(sizeof(int) * obj->capacity);
    obj->top = -1;
    return obj;
}

void minStackPush(MinStack* obj, int val) {
    if (obj->top == obj->capacity - 1) {
        obj->capacity *= 2;
        obj->stack = (int*)realloc(obj->stack, sizeof(int) * obj->capacity);
        obj->min_stack = (int*)realloc(obj->min_stack, sizeof(int) * obj->capacity);
    }
    obj->top++;
    obj->stack[obj->top] = val;
    if (obj->top == 0 || val <= obj->min_stack[obj->top - 1]) {
        obj->min_stack[obj->top] = val;
    } else {
        obj->min_stack[obj->top] = obj->min_stack[obj->top - 1];
    }
}

void minStackPop(MinStack* obj) {
    if (obj->top != -1) {
        obj->top--;
    }
}

int minStackTop(MinStack* obj) {
    if (obj->top != -1) {
        return obj->stack[obj->top];
    }
    return -1; // Or handle error appropriately, problem constraints imply stack won't be empty for top/min
}

int minStackGetMin(MinStack* obj) {
    if (obj->top != -1) {
        return obj->min_stack[obj->top];
    }
    return -1; // Or handle error appropriately
}

void minStackFree(MinStack* obj) {
    free(obj->stack);
    free(obj->min_stack);
    free(obj);
}