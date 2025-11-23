#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

typedef struct NestedInteger {
    int val;
    bool isInteger;
    struct NestedInteger** list;
    int listSize;
} NestedInteger;

typedef struct {
    int* stack;
    int top;
    NestedInteger** nestedList;
    int listSize;
} NestedIterator;

NestedInteger* makeInteger(int value) {
    NestedInteger* node = (NestedInteger*)malloc(sizeof(NestedInteger));
    node->isInteger = true;
    node->val = value;
    return node;
}

NestedInteger* makeList() {
    NestedInteger* node = (NestedInteger*)malloc(sizeof(NestedInteger));
    node->isInteger = false;
    node->list = NULL;
    node->listSize = 0;
    return node;
}

void addInteger(NestedInteger* list, int value) {
    NestedInteger* integer = makeInteger(value);
    list->list = (NestedInteger**)realloc(list->list, (list->listSize + 1) * sizeof(NestedInteger*));
    list->list[list->listSize++] = integer;
}

void addList(NestedInteger* list, NestedInteger* subList) {
    list->list = (NestedInteger**)realloc(list->list, (list->listSize + 1) * sizeof(NestedInteger*));
    list->list[list->listSize++] = subList;
}

NestedIterator* nestedIteratorCreate(NestedInteger** nestedList, int nestedListSize) {
    NestedIterator* iter = (NestedIterator*)malloc(sizeof(NestedIterator));
    iter->stack = (int*)malloc(nestedListSize * sizeof(int));
    iter->top = 0;
    iter->nestedList = nestedList;
    iter->listSize = nestedListSize;
    for (int i = 0; i < nestedListSize; i++) {
        iter->stack[iter->top++] = i;
    }
    return iter;
}

bool nestedIteratorHasNext(NestedIterator* iter) {
    while (iter->top > 0) {
        int index = iter->stack[iter->top - 1];
        NestedInteger* current = iter->nestedList[index];
        if (current->isInteger) {
            return true;
        } else {
            iter->top--;
            for (int i = current->listSize - 1; i >= 0; i--) {
                iter->stack[iter->top++] = (int)(current->list[i]);
            }
        }
    }
    return false;
}

int nestedIteratorNext(NestedIterator* iter) {
    int index = iter->stack[--iter->top];
    NestedInteger* current = iter->nestedList[index];
    return current->val;
}

void nestedIteratorFree(NestedIterator* iter) {
    free(iter->stack);
    free(iter);
}