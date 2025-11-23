#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* nums;
    int size;
    int index;
    int peeked;
    int peekedValue;
} PeekingIterator;

typedef struct {
    int (*hasNext)(PeekingIterator*);
    int (*next)(PeekingIterator*);
    int (*peek)(PeekingIterator*);
} Iterator;

void initPeekingIterator(PeekingIterator* iter, int* nums, int size) {
    iter->nums = nums;
    iter->size = size;
    iter->index = 0;
    iter->peeked = 0;
    iter->peekedValue = 0;
}

int hasNext(PeekingIterator* iter) {
    return iter->index < iter->size;
}

int next(PeekingIterator* iter) {
    if (!hasNext(iter)) return -1;
    int value = iter->nums[iter->index];
    iter->index++;
    iter->peeked = 0;
    return value;
}

int peek(PeekingIterator* iter) {
    if (!hasNext(iter)) return -1;
    if (iter->peeked) {
        return iter->peekedValue;
    }
    iter->peekedValue = iter->nums[iter->index];
    iter->peeked = 1;
    return iter->peekedValue;
}