#include <stdlib.h>

struct NestedIterator {
    int *flattened;
    int size;
    int index;
};

void flattenHelper(struct NestedInteger **nestedList, int nestedListSize, int *result, int *pos) {
    for (int i = 0; i < nestedListSize; i++) {
        if (nestedList[i] && NestedIntegerIsInteger(nestedList[i])) {
            result[(*pos)++] = NestedIntegerGetInteger(nestedList[i]);
        } else {
            struct NestedInteger **list = NestedIntegerGetList(nestedList[i]);
            int size = NestedIntegerGetListSize(nestedList[i]);
            flattenHelper(list, size, result, pos);
        }
    }
}

int getTotalSize(struct NestedInteger **nestedList, int nestedListSize) {
    int count = 0;
    for (int i = 0; i < nestedListSize; i++) {
        if (nestedList[i] && NestedIntegerIsInteger(nestedList[i])) {
            count++;
        } else {
            struct NestedInteger **list = NestedIntegerGetList(nestedList[i]);
            int size = NestedIntegerGetListSize(nestedList[i]);
            count += getTotalSize(list, size);
        }
    }
    return count;
}

struct NestedIterator *nestedIterCreate(struct NestedInteger **nestedList, int nestedListSize) {
    struct NestedIterator *iter = malloc(sizeof(struct NestedIterator));
    iter->size = getTotalSize(nestedList, nestedListSize);
    iter->flattened = malloc(iter->size * sizeof(int));
    iter->index = 0;
    int pos = 0;
    flattenHelper(nestedList, nestedListSize, iter->flattened, &pos);
    return iter;
}

bool nestedIterHasNext(struct NestedIterator *iter) {
    return iter->index < iter->size;
}

int nestedIterNext(struct NestedIterator *iter) {
    return iter->flattened[iter->index++];
}

void nestedIterFree(struct NestedIterator *iter) {
    free(iter->flattened);
    free(iter);
}