#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int* counts;
    int index;
} RLEIterator;

RLEIterator* rLEIteratorCreate(int* encoded, int encodedSize) {
    RLEIterator* obj = (RLEIterator*)malloc(sizeof(RLEIterator));
    obj->nums = (int*)malloc(encodedSize * sizeof(int));
    obj->counts = (int*)malloc(encodedSize * sizeof(int));
    for (int i = 0; i < encodedSize; i++) {
        obj->nums[i] = encoded[i];
    }
    for (int i = 1; i < encodedSize; i += 2) {
        obj->counts[i - 1] = encoded[i];
    }
    obj->index = 0;
    return obj;
}

int rLEIteratorNext(RLEIterator* obj, int n) {
    while (obj->index < (int)(sizeof(obj->nums) / sizeof(obj->nums[0])) && n > 0) {
        if (obj->counts[obj->index] > n) {
            obj->counts[obj->index] -= n;
            return obj->nums[obj->index];
        } else {
            n -= obj->counts[obj->index];
            obj->index++;
        }
    }
    return -1;
}

void rLEIteratorFree(RLEIterator* obj) {
    free(obj->nums);
    free(obj->counts);
    free(obj);
}