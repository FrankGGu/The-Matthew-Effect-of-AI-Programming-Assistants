#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int* data;
    int capacity;
    int size;
} Stack;

typedef struct {
    Stack** stacks;
    int stackCount;
    int capacity;
    int topIndex;
} DinnerPlateStacks;

DinnerPlateStacks* dinnerPlateStacksCreate(int capacity) {
    DinnerPlateStacks* obj = (DinnerPlateStacks*)malloc(sizeof(DinnerPlateStacks));
    obj->stacks = (Stack**)malloc(1000 * sizeof(Stack*));
    obj->stackCount = 0;
    obj->capacity = capacity;
    obj->topIndex = -1;
    return obj;
}

void dinnerPlateStacksPush(DinnerPlateStacks* obj, int val) {
    if (obj->topIndex == -1 || obj->stacks[obj->topIndex]->size == obj->capacity) {
        Stack* newStack = (Stack*)malloc(sizeof(Stack));
        newStack->data = (int*)malloc(obj->capacity * sizeof(int));
        newStack->capacity = obj->capacity;
        newStack->size = 0;
        obj->stacks[++obj->topIndex] = newStack;
    }
    obj->stacks[obj->topIndex]->data[obj->stacks[obj->topIndex]->size++] = val;
}

int dinnerPlateStacksPop(DinnerPlateStacks* obj) {
    while (obj->topIndex >= 0 && obj->stacks[obj->topIndex]->size == 0) {
        free(obj->stacks[obj->topIndex--]);
    }
    if (obj->topIndex < 0) return INT_MIN;
    int val = obj->stacks[obj->topIndex]->data[--obj->stacks[obj->topIndex]->size];
    return val;
}

int dinnerPlateStacksPopAt(int index, DinnerPlateStacks* obj) {
    if (index < 0 || index > obj->topIndex) return INT_MIN;
    if (obj->stacks[index]->size == 0) return INT_MIN;
    int val = obj->stacks[index]->data[--obj->stacks[index]->size];
    return val;
}

void dinnerPlateStacksDestroy(DinnerPlateStacks* obj) {
    for (int i = 0; i <= obj->topIndex; i++) {
        free(obj->stacks[i]->data);
        free(obj->stacks[i]);
    }
    free(obj->stacks);
    free(obj);
}