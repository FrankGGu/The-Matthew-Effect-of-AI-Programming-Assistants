struct Iterator {
    int *array;
    int size;
    int index;
};

struct Iterator* iteratorCreate(int* nums, int numsSize) {
    struct Iterator* it = malloc(sizeof(struct Iterator));
    it->array = nums;
    it->size = numsSize;
    it->index = 0;
    return it;
}

int iteratorHasNext(struct Iterator* obj) {
    return obj->index < obj->size;
}

int iteratorNext(struct Iterator* obj) {
    return obj->array[obj->index++];
}

void iteratorFree(struct Iterator* obj) {
    free(obj);
}

struct PeekingIterator {
    struct Iterator* iter;
    int next_val;
    int has_next;
};

struct PeekingIterator* peekingIteratorCreate(struct Iterator* iterator) {
    struct PeekingIterator* p_iter = malloc(sizeof(struct PeekingIterator));
    p_iter->iter = iterator;
    p_iter->has_next = iteratorHasNext(iterator);
    p_iter->next_val = p_iter->has_next ? iteratorNext(iterator) : 0;
    return p_iter;
}

int peekingIteratorNext(struct PeekingIterator* obj) {
    int val = obj->next_val;
    obj->has_next = iteratorHasNext(obj->iter);
    obj->next_val = obj->has_next ? iteratorNext(obj->iter) : 0;
    return val;
}

int peekingIteratorPeek(struct PeekingIterator* obj) {
    return obj->next_val;
}

void peekingIteratorFree(struct PeekingIterator* obj) {
    free(obj);
}