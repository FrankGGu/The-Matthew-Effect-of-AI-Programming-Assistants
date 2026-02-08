#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int id;
    int start;
    int size;
} Block;

typedef struct {
    int n;
    int size;
    Block *blocks;
} Allocator;

Allocator* allocatorCreate(int n) {
    Allocator* obj = (Allocator*)malloc(sizeof(Allocator));
    obj->n = 0;
    obj->size = n;
    obj->blocks = (Block*)malloc(n * sizeof(Block));
    return obj;
}

int allocate(Allocator* obj, int size, int mID) {
    int start = -1;
    int current = 0;

    if (obj->n == 0) {
        if (size <= obj->size) {
            start = 0;
        }
    } else {
        if (size <= obj->blocks[0].start) {
            start = 0;
        } else {
            for (int i = 0; i < obj->n - 1; i++) {
                if (size <= (obj->blocks[i+1].start - (obj->blocks[i].start + obj->blocks[i].size))) {
                    start = obj->blocks[i].start + obj->blocks[i].size;
                    break;
                }
            }
            if (start == -1) {
                if (size <= (obj->size - (obj->blocks[obj->n-1].start + obj->blocks[obj->n-1].size))) {
                    start = obj->blocks[obj->n-1].start + obj->blocks[obj->n-1].size;
                }
            }
        }
    }

    if (start != -1) {
        Block newBlock;
        newBlock.id = mID;
        newBlock.start = start;
        newBlock.size = size;

        int insertIndex = 0;
        while (insertIndex < obj->n && obj->blocks[insertIndex].start < start) {
            insertIndex++;
        }

        for (int i = obj->n; i > insertIndex; i--) {
            obj->blocks[i] = obj->blocks[i-1];
        }

        obj->blocks[insertIndex] = newBlock;
        obj->n++;
        return start;
    }

    return -1;
}

int free(Allocator* obj, int mID) {
    int count = 0;
    int i = 0;
    while(i < obj->n){
        if (obj->blocks[i].id == mID) {
            for (int j = i; j < obj->n - 1; j++) {
                obj->blocks[j] = obj->blocks[j+1];
            }
            obj->n--;
            count++;
            i--;
        }
        i++;
    }
    return count;
}

void allocatorFree(Allocator* obj) {
    free(obj->blocks);
    free(obj);
}