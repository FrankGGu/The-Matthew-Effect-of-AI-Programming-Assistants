#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int val;
    int freq;
} Element;

typedef struct {
    int size;
    Element* data;
} Stack;

typedef struct {
    int max_freq;
    int* freq_map;
    Stack** freq_stack;
} FreqStack;

void push(FreqStack* obj, int val) {
    obj->freq_map[val]++;
    int freq = obj->freq_map[val];
    if (freq > obj->max_freq) {
        obj->max_freq = freq;
    }
    if (obj->freq_stack[freq] == NULL) {
        obj->freq_stack[freq] = (Stack*)malloc(sizeof(Stack));
        obj->freq_stack[freq]->size = 0;
        obj->freq_stack[freq]->data = (Element*)malloc(sizeof(Element) * 1);
    }
    obj->freq_stack[freq]->data[obj->freq_stack[freq]->size].val = val;
    obj->freq_stack[freq]->data[obj->freq_stack[freq]->size].freq = freq;
    obj->freq_stack[freq]->size++;
}

int pop(FreqStack* obj) {
    int val = obj->freq_stack[obj->max_freq]->data[obj->freq_stack[obj->max_freq]->size - 1].val;
    obj->freq_map[val]--;
    obj->freq_stack[obj->max_freq]->size--;
    if (obj->freq_stack[obj->max_freq]->size == 0) {
        obj->max_freq--;
    }
    return val;
}

FreqStack* freqStackCreate() {
    FreqStack* obj = (FreqStack*)malloc(sizeof(FreqStack));
    obj->max_freq = 0;
    obj->freq_map = (int*)calloc(10001, sizeof(int));
    obj->freq_stack = (Stack**)calloc(10001, sizeof(Stack*));
    return obj;
}

void freqStackFree(FreqStack* obj) {
    for (int i = 0; i <= obj->max_freq; i++) {
        free(obj->freq_stack[i]->data);
        free(obj->freq_stack[i]);
    }
    free(obj->freq_map);
    free(obj->freq_stack);
    free(obj);
}