#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    struct NestedInteger **stack;
    int *indices;
    int size;
    int capacity;
} NestedIterator;

NestedIterator *nestedIteratorCreate(struct NestedInteger **nestedList, int nestedListSize) {
    NestedIterator *iter = (NestedIterator *)malloc(sizeof(NestedIterator));
    iter->stack = (struct NestedInteger **)malloc(sizeof(struct NestedInteger *) * (nestedListSize + 1));
    iter->indices = (int *)malloc(sizeof(int) * (nestedListSize + 1));
    iter->size = 1;
    iter->capacity = nestedListSize + 1;
    iter->stack[0] = nestedList;
    iter->indices[0] = 0;
    return iter;
}

bool nestedIteratorHasNext(NestedIterator *iter) {
    while (iter->size > 0) {
        struct NestedInteger **currentList = iter->stack[iter->size - 1];
        int index = iter->indices[iter->size - 1];
        int listSize = (*(currentList - 1));

        if (index == listSize) {
            iter->size--;
            continue;
        }

        struct NestedInteger *nestedInteger = currentList[index];

        if (nestedInteger->isInteger(nestedInteger)) {
            return true;
        } else {
            struct NestedInteger **newList = nestedInteger->getList(nestedInteger);
            int newListSize = nestedInteger->getListSize(nestedInteger);

            if (iter->size == iter->capacity) {
                iter->capacity *= 2;
                iter->stack = (struct NestedInteger **)realloc(iter->stack, sizeof(struct NestedInteger *) * iter->capacity);
                iter->indices = (int *)realloc(iter->indices, sizeof(int) * iter->capacity);
            }

            iter->stack[iter->size] = newList;
            iter->indices[iter->size] = 0;
            iter->size++;
            (*(newList - 1)) = newListSize;
        }

        iter->indices[iter->size - 2]++;
    }

    return false;
}

int nestedIteratorNext(NestedIterator *iter) {
    struct NestedInteger **currentList = iter->stack[iter->size - 1];
    int index = iter->indices[iter->size - 1];
    struct NestedInteger *nestedInteger = currentList[index];
    iter->indices[iter->size - 1]++;
    return nestedInteger->getInteger(nestedInteger);
}

void nestedIteratorFree(NestedIterator *iter) {
    free(iter->stack);
    free(iter->indices);
    free(iter);
}