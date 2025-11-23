#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int value;
} Accumulator;

Accumulator* AccumulatorCreate() {
    Accumulator* obj = (Accumulator*)malloc(sizeof(Accumulator));
    obj->value = 0;
    return obj;
}

void AccumulatorAdd(Accumulator* obj, int num) {
    obj->value += num;
}

int AccumulatorGet(Accumulator* obj) {
    return obj->value;
}

void AccumulatorFree(Accumulator* obj) {
    free(obj);
}