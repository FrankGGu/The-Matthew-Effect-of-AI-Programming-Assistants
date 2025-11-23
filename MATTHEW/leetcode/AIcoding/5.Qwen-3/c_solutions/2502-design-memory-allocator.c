#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int start;
    int end;
} Block;

typedef struct {
    Block* blocks;
    int size;
    int capacity;
} Allocator;

Allocator* allocatorCreate(int n) {
    Allocator* obj = (Allocator*)malloc(sizeof(Allocator));
    obj->blocks = (Block*)malloc(n * sizeof(Block));
    obj->size = 0;
    obj->capacity = n;
    return obj;
}

int allocatorAllocate(Allocator* obj, int size, int mID) {
    int i;
    for (i = 0; i < obj->capacity - size + 1; i++) {
        int j;
        for (j = 0; j < obj->size; j++) {
            if (obj->blocks[j].start <= i && obj->blocks[j].end >= i) {
                break;
            }
        }
        if (j == obj->size) {
            for (j = 0; j < obj->size; j++) {
                if (obj->blocks[j].start <= i + size - 1 && obj->blocks[j].end >= i) {
                    break;
                }
            }
            if (j == obj->size) {
                obj->blocks[obj->size].start = i;
                obj->blocks[obj->size].end = i + size - 1;
                obj->size++;
                return i;
            }
        }
    }
    return -1;
}

int allocatorFree(Allocator* obj, int mID) {
    int count = 0;
    for (int i = 0; i < obj->size; i++) {
        if (obj->blocks[i].start != -1 && obj->blocks[i].end != -1) {
            count++;
            obj->blocks[i].start = -1;
            obj->blocks[i].end = -1;
        }
    }
    return count;
}

void allocatorFreeAll(Allocator* obj) {
    free(obj->blocks);
    free(obj);
}