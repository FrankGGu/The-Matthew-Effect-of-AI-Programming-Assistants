#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    bool (*hasNext)(struct Iterator *iter);
    int (*next)(struct Iterator *iter);
} Iterator;

typedef struct {
    Iterator *base_iter;
    bool has_peeked;
    int peeked_val;
} PeekingIterator;

PeekingIterator* peekingIteratorCreate(Iterator* iter) {
    PeekingIterator* obj = (PeekingIterator*) malloc(sizeof(PeekingIterator));
    obj->base_iter = iter;
    obj->has_peeked = false;
    obj->peeked_val = 0;
    return obj;
}

int peekingIteratorPeek(PeekingIterator* obj) {
    if (!obj->has_peeked) {
        obj->peeked_val = obj->base_iter->next(obj->base_iter);
        obj->has_peeked = true;
    }
    return obj->peeked_val;
}

int peekingIteratorNext(PeekingIterator* obj) {
    if (obj->has_peeked) {
        int val = obj->peeked_val;
        obj->has_peeked = false;
        return val;
    } else {
        return obj->base_iter->next(obj->base_iter);
    }
}

bool peekingIteratorHasNext(PeekingIterator* obj) {
    if (obj->has_peeked) {
        return true;
    } else {
        return obj->base_iter->hasNext(obj->base_iter);
    }
}

void peekingIteratorFree(PeekingIterator* obj) {
    free(obj);
}