#include <stdlib.h>
#include <stdbool.h>

typedef struct NestedInteger_ NestedInteger;

bool NestedIntegerIsInteger(NestedInteger *ni);
int NestedIntegerGetInteger(NestedInteger *ni);
NestedInteger** NestedIntegerGetList(NestedInteger *ni, int *returnSize);

typedef struct {
    NestedInteger** stack;
    int stack_top;
    int stack_capacity;
} NestedIterator;

void ni_stack_push(NestedIterator* obj, NestedInteger* ni) {
    if (obj->stack_top == obj->stack_capacity) {
        obj->stack_capacity = obj->stack_capacity == 0 ? 4 : obj->stack_capacity * 2;
        obj->stack = (NestedInteger**)realloc(obj->stack, sizeof(NestedInteger*) * obj->stack_capacity);
    }
    obj->stack[obj->stack_top++] = ni;
}

NestedInteger* ni_stack_pop(NestedIterator* obj) {
    return obj->stack[--obj->stack_top];
}

NestedInteger* ni_stack_peek(NestedIterator* obj) {
    return obj->stack[obj->stack_top - 1];
}

NestedIterator* nestedIteratorCreate(NestedInteger** nestedList, int nestedListSize) {
    NestedIterator* obj = (NestedIterator*)malloc(sizeof(NestedIterator));
    obj->stack = NULL;
    obj->stack_top = 0;
    obj->stack_capacity = 0;

    for (int i = nestedListSize - 1; i >= 0; --i) {
        ni_stack_push(obj, nestedList[i]);
    }

    return obj;
}

int nestedIteratorNext(NestedIterator* obj) {
    NestedInteger* top_ni = ni_stack_pop(obj);
    return NestedIntegerGetInteger(top_ni);
}

bool nestedIteratorHasNext(NestedIterator* obj) {
    while (obj->stack_top > 0) {
        NestedInteger* top_ni = ni_stack_peek(obj);
        if (NestedIntegerIsInteger(top_ni)) {
            return true;
        } else {
            ni_stack_pop(obj);
            int list_size;
            NestedInteger** sub_list = NestedIntegerGetList(top_ni, &list_size);

            for (int i = list_size - 1; i >= 0; --i) {
                ni_stack_push(obj, sub_list[i]);
            }
        }
    }
    return false;
}

void nestedIteratorFree(NestedIterator* obj) {
    free(obj->stack);
    free(obj);
}