#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    char* bits;
    int size;
    int setCount;
} Bitset;

Bitset* bitsetCreate(char* data, int size) {
    Bitset* obj = (Bitset*)malloc(sizeof(Bitset));
    obj->bits = (char*)malloc(size * sizeof(char));
    memcpy(obj->bits, data, size);
    obj->size = size;
    obj->setCount = 0;
    for (int i = 0; i < size; i++) {
        if (obj->bits[i] == '1') {
            obj->setCount++;
        }
    }
    return obj;
}

void bitsetFlip(Bitset* obj) {
    for (int i = 0; i < obj->size; i++) {
        obj->bits[i] = (obj->bits[i] == '0') ? '1' : '0';
    }
    obj->setCount = obj->size - obj->setCount;
}

void bitsetSet(Bitset* obj, int idx, int val) {
    if (val == 1 && obj->bits[idx] == '0') {
        obj->setCount++;
    } else if (val == 0 && obj->bits[idx] == '1') {
        obj->setCount--;
    }
    obj->bits[idx] = (val == 1) ? '1' : '0';
}

int bitsetGet(Bitset* obj, int idx) {
    return obj->bits[idx] - '0';
}

int bitsetGetSize(Bitset* obj) {
    return obj->size;
}

void bitsetFree(Bitset* obj) {
    free(obj->bits);
    free(obj);
}