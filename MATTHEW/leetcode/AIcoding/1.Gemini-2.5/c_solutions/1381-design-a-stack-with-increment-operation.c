#include <stdlib.h>
#include <string.h> // Not strictly needed, but common for C solutions

typedef struct {
    int* stack;
    int maxSize;
    int top;
} CustomStack;

CustomStack* customStackCreate(int maxSize) {
    CustomStack* obj = (CustomStack*)malloc(sizeof(CustomStack));
    obj->stack = (int*)malloc(sizeof(int) * maxSize);
    obj->maxSize = maxSize;
    obj->top = -1; // Indicates an empty stack
    return obj;
}

void customStackPush(CustomStack* obj, int x) {
    if (obj->top < obj->maxSize - 1) { // Check if stack is not full
        obj->top++;
        obj->stack[obj->top] = x;
    }
}

int customStackPop(CustomStack* obj) {
    if (obj->top == -1) { // Check if stack is empty
        return -1;
    } else {
        int val = obj->stack[obj->top];
        obj->top--;
        return val;
    }
}

void customStackIncrement(CustomStack* obj, int k, int val) {
    // Determine the actual number of elements to increment
    // It's the minimum of k and the current number of elements in the stack (obj->top + 1)
    int limit = (k < obj->top + 1) ? k : (obj->top + 1);

    for (int i = 0; i < limit; i++) {
        obj->stack[i] += val;
    }
}

void customStackFree(CustomStack* obj) {
    free(obj->stack);
    free(obj);
}