#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int* nums;
    int size;
    int current;
    bool hasNext;
} PeekingIterator;

PeekingIterator* peekingIteratorCreate(int* nums, int numsSize) {
    PeekingIterator* iterator = (PeekingIterator*)malloc(sizeof(PeekingIterator));
    iterator->nums = nums;
    iterator->size = numsSize;
    iterator->current = 0;
    iterator->hasNext = (numsSize > 0);
    return iterator;
}

int peekingIteratorPeek(PeekingIterator* iterator) {
    return iterator->nums[iterator->current];
}

int peekingIteratorNext(PeekingIterator* iterator) {
    int result = iterator->nums[iterator->current];
    iterator->current++;
    iterator->hasNext = (iterator->current < iterator->size);
    return result;
}

bool peekingIteratorHasNext(PeekingIterator* iterator) {
    return iterator->hasNext;
}

void peekingIteratorFree(PeekingIterator* iterator) {
    free(iterator);
}