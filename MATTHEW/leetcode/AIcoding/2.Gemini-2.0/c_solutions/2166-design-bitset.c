#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    unsigned long* bits;
    int size;
    int count;
} Bitset;

Bitset* bitsetCreate(int size) {
    Bitset* obj = (Bitset*)malloc(sizeof(Bitset));
    obj->size = size;
    int num_longs = (size + 63) / 64;
    obj->bits = (unsigned long*)calloc(num_longs, sizeof(unsigned long));
    obj->count = 0;
    return obj;
}

void bitsetFix(Bitset* obj, int idx) {
    int long_idx = idx / 64;
    int bit_idx = idx % 64;
    if ((obj->bits[long_idx] & (1UL << bit_idx)) == 0) {
        obj->bits[long_idx] |= (1UL << bit_idx);
        obj->count++;
    }
}

void bitsetUnfix(Bitset* obj, int idx) {
    int long_idx = idx / 64;
    int bit_idx = idx % 64;
    if ((obj->bits[long_idx] & (1UL << bit_idx)) != 0) {
        obj->bits[long_idx] &= ~(1UL << bit_idx);
        obj->count--;
    }
}

void bitsetFlip(Bitset* obj) {
    int num_longs = (obj->size + 63) / 64;
    for (int i = 0; i < num_longs; i++) {
        obj->bits[i] = ~obj->bits[i];
    }
    obj->count = obj->size - obj->count;
}

bool bitsetAll(Bitset* obj) {
    return obj->count == obj->size;
}

bool bitsetOne(Bitset* obj) {
    return obj->count > 0;
}

int bitsetCount(Bitset* obj) {
    return obj->count;
}

char* bitsetToString(Bitset* obj) {
    char* str = (char*)malloc(obj->size + 1);
    for (int i = 0; i < obj->size; i++) {
        int long_idx = i / 64;
        int bit_idx = i % 64;
        if (obj->bits[long_idx] & (1UL << bit_idx)) {
            str[i] = '1';
        } else {
            str[i] = '0';
        }
    }
    str[obj->size] = '\0';
    return str;
}

void bitsetFree(Bitset* obj) {
    free(obj->bits);
    free(obj);
}