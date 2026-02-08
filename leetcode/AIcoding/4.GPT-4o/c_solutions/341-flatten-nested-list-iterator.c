typedef struct NestedInteger {
    bool isInteger;
    int value;
    struct NestedInteger** list;
    int size;
} NestedInteger;

typedef struct {
    NestedInteger** stack;
    int top;
    int size;
} NestedIterator;

NestedIterator* nestedIteratorCreate(NestedInteger* nestedList[], int nestedListSize) {
    NestedIterator* it = malloc(sizeof(NestedIterator));
    it->stack = malloc(nestedListSize * sizeof(NestedInteger*));
    it->top = 0;
    it->size = nestedListSize;
    for (int i = nestedListSize - 1; i >= 0; i--) {
        it->stack[it->top++] = nestedList[i];
    }
    return it;
}

int nestedIteratorHasNext(NestedIterator* it) {
    while (it->top > 0) {
        NestedInteger* ni = it->stack[it->top - 1];
        if (ni->isInteger) {
            return 1;
        }
        it->top--;
        for (int i = ni->size - 1; i >= 0; i--) {
            it->stack[it->top++] = ni->list[i];
        }
    }
    return 0;
}

int nestedIteratorNext(NestedIterator* it) {
    NestedInteger* ni = it->stack[--it->top];
    return ni->value;
}

void nestedIteratorFree(NestedIterator* it) {
    free(it->stack);
    free(it);
}