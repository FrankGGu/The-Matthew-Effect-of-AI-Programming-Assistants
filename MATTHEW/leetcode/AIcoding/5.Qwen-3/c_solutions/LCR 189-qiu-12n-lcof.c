#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* stack;
    int top;
    int capacity;
} CustomStack;

CustomStack* customStackCreate(int maxSize) {
    CustomStack* obj = (CustomStack*)malloc(sizeof(CustomStack));
    obj->stack = (int*)malloc(maxSize * sizeof(int));
    obj->top = -1;
    obj->capacity = maxSize;
    return obj;
}

void customStackPush(CustomStack* obj, int x) {
    if (obj->top < obj->capacity - 1) {
        obj->top++;
        obj->stack[obj->top] = x;
    }
}

int customStackPop(CustomStack* obj) {
    if (obj->top == -1) {
        return -1;
    }
    int val = obj->stack[obj->top];
    obj->top--;
    return val;
}

void customStackIncrement(CustomStack* obj, int k, int val) {
    int limit = (obj->top + 1) < k ? obj->top + 1 : k;
    for (int i = 0; i < limit; i++) {
        obj->stack[i] += val;
    }
}

void customStackFree(CustomStack* obj) {
    free(obj->stack);
    free(obj);
}