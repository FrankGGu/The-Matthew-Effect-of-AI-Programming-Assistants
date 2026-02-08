#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int val;
    int freq;
    int push_order;
} Element;

typedef struct {
    Element *data;
    int size;
    int capacity;
} Stack;

Stack* stackCreate(int capacity) {
    Stack* stack = (Stack*)malloc(sizeof(Stack));
    stack->data = (Element*)malloc(capacity * sizeof(Element));
    stack->size = 0;
    stack->capacity = capacity;
    return stack;
}

void stackPush(Stack* stack, Element val) {
    if (stack->size == stack->capacity) {
        stack->capacity *= 2;
        stack->data = (Element*)realloc(stack->data, stack->capacity * sizeof(Element));
    }
    stack->data[stack->size++] = val;
}

Element stackPop(Stack* stack) {
    if (stack->size > 0) {
        return stack->data[--stack->size];
    } else {
        Element empty = {-1, -1, -1};
        return empty;
    }
}

int stackSize(Stack* stack) {
    return stack->size;
}

bool stackIsEmpty(Stack* stack) {
    return stack->size == 0;
}

void stackFree(Stack* stack) {
    free(stack->data);
    free(stack);
}

typedef struct {
    Stack **freq_stacks;
    int *freq_count;
    int max_freq;
    int push_count;
    int capacity;
} FreqStack;

FreqStack* freqStackCreate() {
    FreqStack* obj = (FreqStack*)malloc(sizeof(FreqStack));
    obj->freq_stacks = (Stack**)malloc(sizeof(Stack*));
    obj->freq_stacks[0] = NULL;
    obj->freq_count = (int*)calloc(20001, sizeof(int));
    obj->max_freq = 0;
    obj->push_count = 0;
    obj->capacity = 1;
    return obj;
}

void freqStackPush(FreqStack* obj, int val) {
    obj->freq_count[val + 10000]++;
    int freq = obj->freq_count[val + 10000];

    if (freq > obj->max_freq) {
        obj->max_freq = freq;
        obj->capacity = freq + 1;
        obj->freq_stacks = (Stack**)realloc(obj->freq_stacks, obj->capacity * sizeof(Stack*));
        obj->freq_stacks[freq] = stackCreate(1);
    } else if (obj->freq_stacks[freq] == NULL) {
        obj->freq_stacks[freq] = stackCreate(1);
    }

    Element new_element = {val, freq, obj->push_count++};
    stackPush(obj->freq_stacks[freq], new_element);
}

int freqStackPop(FreqStack* obj) {
    Stack* top_stack = obj->freq_stacks[obj->max_freq];
    Element top_element = stackPop(top_stack);
    int val = top_element.val;
    obj->freq_count[val + 10000]--;

    if (stackIsEmpty(top_stack)) {
        obj->max_freq--;
    }

    return val;
}

void freqStackFree(FreqStack* obj) {
    for (int i = 1; i <= obj->max_freq; i++) {
        stackFree(obj->freq_stacks[i]);
    }
    free(obj->freq_stacks);
    free(obj->freq_count);
    free(obj);
}