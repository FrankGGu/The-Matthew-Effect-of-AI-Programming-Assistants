#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *stack;
    int top;
    int size;
} CustomStack;

CustomStack* customStackCreate(int maxSize) {
    CustomStack *obj = (CustomStack*)malloc(sizeof(CustomStack));
    obj->stack = (int*)malloc(maxSize * sizeof(int));
    obj->top = -1;
    obj->size = maxSize;
    return obj;
}

void customStackPush(CustomStack* obj, int x) {
    if (obj->top < obj->size - 1) {
        obj->top++;
        obj->stack[obj->top] = x;
    }
}

void customStackPop(CustomStack* obj) {
    if (obj->top >= 0) {
        obj->top--;
    }
}

void customStackIncrement(CustomStack* obj, int k, int val) {
    int i;
    for (i = 0; i < k && i <= obj->top; i++) {
        obj->stack[i] += val;
    }
}

void customStackFree(CustomStack* obj) {
    free(obj->stack);
    free(obj);
}