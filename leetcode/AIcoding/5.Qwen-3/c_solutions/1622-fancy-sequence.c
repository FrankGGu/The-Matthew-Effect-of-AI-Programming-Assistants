#include <stdio.h>
#include <stdlib.h>

typedef struct {
    long long a;
    long long b;
} Operation;

typedef struct {
    Operation *ops;
    int size;
} Fancy;

Fancy* fancyCreate() {
    Fancy *f = (Fancy*)malloc(sizeof(Fancy));
    f->ops = NULL;
    f->size = 0;
    return f;
}

void fancyAppend(Fancy* obj, int val) {
    Operation op;
    op.a = 1;
    op.b = val;
    obj->ops = (Operation*)realloc(obj->ops, (obj->size + 1) * sizeof(Operation));
    obj->ops[obj->size++] = op;
}

void fancyAddAll(Fancy* obj, int val) {
    Operation op;
    op.a = 1;
    op.b = val;
    obj->ops = (Operation*)realloc(obj->ops, (obj->size + 1) * sizeof(Operation));
    obj->ops[obj->size++] = op;
}

void fancyMultAll(Fancy* obj, int val) {
    Operation op;
    op.a = val;
    op.b = 0;
    obj->ops = (Operation*)realloc(obj->ops, (obj->size + 1) * sizeof(Operation));
    obj->ops[obj->size++] = op;
}

int fancyGet(const Fancy* obj, int idx) {
    long long result = 0;
    for (int i = 0; i < obj->size; ++i) {
        if (obj->ops[i].a != 1 || obj->ops[i].b != 0) {
            result = (result * obj->ops[i].a + obj->ops[i].b) % 1000000007;
        }
    }
    return result;
}

void fancyFree(Fancy* obj) {
    free(obj->ops);
    free(obj);
}