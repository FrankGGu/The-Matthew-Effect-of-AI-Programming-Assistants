#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int *encoding;
    int size;
    int index;
    long long count;
} RLEIterator;

RLEIterator* rLEIteratorCreate(int* encoding, int encodingSize) {
    RLEIterator* obj = (RLEIterator*)malloc(sizeof(RLEIterator));
    obj->encoding = encoding;
    obj->size = encodingSize;
    obj->index = 0;
    obj->count = 0;
    return obj;
}

int rLEIteratorNext(RLEIterator* obj, int n) {
    while (obj->index < obj->size) {
        long long remaining = obj->encoding[obj->index] - obj->count;
        if (n <= remaining) {
            obj->count += n;
            return obj->encoding[obj->index + 1];
        } else {
            n -= remaining;
            obj->index += 2;
            obj->count = 0;
        }
    }
    return -1;
}

void rLEIteratorFree(RLEIterator* obj) {
    free(obj);
}