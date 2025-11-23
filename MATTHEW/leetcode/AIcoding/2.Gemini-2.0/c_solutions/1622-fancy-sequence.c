#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#define MOD 1000000007

typedef struct {
    long long mul;
    long long add;
} Operation;

typedef struct {
    int* arr;
    int size;
    int capacity;
    Operation* ops;
    int opsSize;
} Fancy;

long long power(long long base, long long exp) {
    long long res = 1;
    base %= MOD;
    while (exp > 0) {
        if (exp % 2 == 1) res = (res * base) % MOD;
        base = (base * base) % MOD;
        exp /= 2;
    }
    return res;
}

long long modInverse(long long n) {
    return power(n, MOD - 2);
}

Fancy* fancyCreate() {
    Fancy* obj = (Fancy*)malloc(sizeof(Fancy));
    obj->arr = NULL;
    obj->size = 0;
    obj->capacity = 0;
    obj->ops = (Operation*)malloc(100000 * sizeof(Operation));
    obj->opsSize = 0;
    return obj;
}

void fancyAppend(Fancy* obj, int val) {
    if (obj->size == obj->capacity) {
        obj->capacity = (obj->capacity == 0) ? 1 : obj->capacity * 2;
        obj->arr = (int*)realloc(obj->arr, obj->capacity * sizeof(int));
    }
    obj->arr[obj->size++] = val;
}

void fancyMultAll(Fancy* obj, int m) {
    obj->ops[obj->opsSize].mul = m;
    obj->ops[obj->opsSize].add = 0;
    obj->opsSize++;
}

void fancyAddAll(Fancy* obj, int inc) {
    obj->ops[obj->opsSize].mul = 1;
    obj->ops[obj->opsSize].add = inc;
    obj->opsSize++;
}

int fancyGetIndex(Fancy* obj, int idx) {
    if (idx >= obj->size) return -1;

    long long val = obj->arr[idx];
    long long mul = 1;
    long long add = 0;

    for (int i = obj->opsSize - 1; i >= 0; i--) {
        mul = (mul * obj->ops[i].mul) % MOD;
        add = (add * obj->ops[i].mul + obj->ops[i].add) % MOD;
    }

    return (val * mul + add + MOD) % MOD;
}

void fancyFree(Fancy* obj) {
    free(obj->arr);
    free(obj->ops);
    free(obj);
}