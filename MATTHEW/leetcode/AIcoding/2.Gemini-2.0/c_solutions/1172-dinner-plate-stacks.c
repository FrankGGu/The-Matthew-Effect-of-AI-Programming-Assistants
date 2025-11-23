#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct Stack {
    int *data;
    int top;
    int capacity;
} Stack;

Stack* createStack(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->capacity = capacity;
    stack->top = -1;
    stack->data = (int*)malloc(sizeof(int) * capacity);
    return stack;
}

bool isFull(Stack* stack) {
    return stack->top == stack->capacity - 1;
}

bool isEmpty(Stack* stack) {
    return stack->top == -1;
}

void push(Stack* stack, int val) {
    stack->data[++stack->top] = val;
}

int pop(Stack* stack) {
    return stack->data[stack->top--];
}

int peek(Stack* stack) {
    return stack->data[stack->top];
}

void freeStack(Stack* stack) {
    free(stack->data);
    free(stack);
}

typedef struct {
    Stack** stacks;
    int capacity;
    int stackCapacity;
    int numStacks;
    int leftMost;
    int rightMost;
} DinnerPlates;

DinnerPlates* dinnerPlatesCreate(int capacity) {
    DinnerPlates* dinnerPlates = (DinnerPlates*)malloc(sizeof(DinnerPlates));
    dinnerPlates->capacity = capacity;
    dinnerPlates->stackCapacity = 0;
    dinnerPlates->numStacks = 0;
    dinnerPlates->stacks = NULL;
    dinnerPlates->leftMost = 0;
    dinnerPlates->rightMost = 0;
    return dinnerPlates;
}

void dinnerPlatesPush(DinnerPlates* obj, int val) {
    if (obj->stackCapacity == 0) {
        obj->stackCapacity = 100000;
        obj->stacks = (Stack**)malloc(sizeof(Stack*) * obj->stackCapacity);
        obj->numStacks = 0;
        obj->leftMost = 0;
        obj->rightMost = 0;
    }

    int i = obj->leftMost;
    while (i < obj->numStacks && isFull(obj->stacks[i])) {
        i++;
    }

    if (i == obj->numStacks) {
        if (obj->numStacks == obj->stackCapacity) {
            obj->stackCapacity *= 2;
            obj->stacks = (Stack**)realloc(obj->stacks, sizeof(Stack*) * obj->stackCapacity);
        }
        obj->stacks[obj->numStacks] = createStack(obj->capacity);
        obj->numStacks++;
    }

    push(obj->stacks[i], val);
    obj->leftMost = 0;
    obj->rightMost = obj->numStacks - 1;
}

int dinnerPlatesPop(DinnerPlates* obj) {
    if (obj->numStacks == 0) return -1;

    int i = obj->rightMost;
    while (i >= 0 && isEmpty(obj->stacks[i])) {
        i--;
    }

    if (i == -1) return -1;

    int val = pop(obj->stacks[i]);
    obj->rightMost = obj->numStacks - 1;

    return val;
}

int dinnerPlatesPopAtStack(DinnerPlates* obj, int index) {
    if (index < 0 || index >= obj->numStacks || isEmpty(obj->stacks[index])) return -1;

    int val = pop(obj->stacks[index]);

    obj->leftMost = 0;
    obj->rightMost = obj->numStacks - 1;

    return val;
}

void dinnerPlatesFree(DinnerPlates* obj) {
    if (obj->stacks != NULL) {
        for (int i = 0; i < obj->numStacks; i++) {
            freeStack(obj->stacks[i]);
        }
        free(obj->stacks);
    }
    free(obj);
}