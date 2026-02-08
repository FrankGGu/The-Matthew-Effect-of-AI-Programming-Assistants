#include <stdio.h>
#include <stdlib.h>

struct FreqStack {
    int *nums;
    int *freq;
    int maxFreq;
    int size;
};

struct FreqStack* freqStackCreate() {
    struct FreqStack *stack = (struct FreqStack *)malloc(sizeof(struct FreqStack));
    stack->nums = (int *)malloc(10000 * sizeof(int));
    stack->freq = (int *)calloc(10000, sizeof(int));
    stack->maxFreq = 0;
    stack->size = 0;
    return stack;
}

void freqStackPush(struct FreqStack* obj, int val) {
    obj->freq[val]++;
    if (obj->freq[val] > obj->maxFreq) {
        obj->maxFreq = obj->freq[val];
    }
    obj->nums[obj->size++] = val;
}

int freqStackPop(struct FreqStack* obj) {
    int popped = -1;
    for (int i = obj->size - 1; i >= 0; i--) {
        if (obj->freq[obj->nums[i]] == obj->maxFreq) {
            popped = obj->nums[i];
            obj->freq[popped]--;
            if (obj->freq[popped] == 0) {
                obj->maxFreq--;
            }
            obj->nums[i] = obj->nums[--obj->size];
            break;
        }
    }
    return popped;
}

void freqStackFree(struct FreqStack* obj) {
    free(obj->nums);
    free(obj->freq);
    free(obj);
}