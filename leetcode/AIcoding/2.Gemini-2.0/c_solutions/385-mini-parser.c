#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct NestedInteger {
    int val;
    bool isInteger;
    struct NestedInteger** list;
    int listSize;
    int listCapacity;
} NestedInteger;

NestedInteger* NestedIntegerCreate() {
    NestedInteger* obj = (NestedInteger*)malloc(sizeof(NestedInteger));
    obj->isInteger = false;
    obj->list = NULL;
    obj->listSize = 0;
    obj->listCapacity = 0;
    return obj;
}

void NestedIntegerFree(NestedInteger* obj) {
    if (!obj) return;
    if (!obj->isInteger) {
        for (int i = 0; i < obj->listSize; i++) {
            NestedIntegerFree(obj->list[i]);
        }
        free(obj->list);
    }
    free(obj);
}

bool NestedIntegerIsInteger(NestedInteger* obj) {
    return obj->isInteger;
}

int NestedIntegerGetInteger(NestedInteger* obj) {
    return obj->val;
}

struct NestedInteger** NestedIntegerGetList(struct NestedInteger* obj, int* returnSize) {
    *returnSize = obj->listSize;
    return obj->list;
}

void NestedIntegerAdd(NestedInteger* obj, NestedInteger* nestedInt) {
    if (obj->list == NULL) {
        obj->listCapacity = 4;
        obj->list = (NestedInteger**)malloc(sizeof(NestedInteger*) * obj->listCapacity);
    } else if (obj->listSize == obj->listCapacity) {
        obj->listCapacity *= 2;
        obj->list = (NestedInteger**)realloc(obj->list, sizeof(NestedInteger*) * obj->listCapacity);
    }
    obj->list[obj->listSize++] = nestedInt;
}

NestedInteger* NestedIntegerInit(int val) {
    NestedInteger* obj = NestedIntegerCreate();
    obj->isInteger = true;
    obj->val = val;
    return obj;
}

NestedInteger* deserialize(char * s){
    int len = strlen(s);
    int pos = 0;

    NestedInteger* parse(char *s, int *pos, int len) {
        if (s[*pos] == '[') {
            (*pos)++;
            NestedInteger* list = NestedIntegerCreate();
            while (s[*pos] != ']') {
                NestedInteger* element = parse(s, pos, len);
                NestedIntegerAdd(list, element);
                if (s[*pos] == ',') {
                    (*pos)++;
                }
            }
            (*pos)++;
            return list;
        } else {
            int sign = 1;
            if (s[*pos] == '-') {
                sign = -1;
                (*pos)++;
            }
            int num = 0;
            while (*pos < len && s[*pos] >= '0' && s[*pos] <= '9') {
                num = num * 10 + (s[*pos] - '0');
                (*pos)++;
            }
            return NestedIntegerInit(sign * num);
        }
    }

    return parse(s, &pos, len);
}