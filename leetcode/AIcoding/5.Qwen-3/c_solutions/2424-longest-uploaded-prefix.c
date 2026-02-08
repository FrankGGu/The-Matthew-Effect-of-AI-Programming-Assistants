#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* prefix;
    int size;
    int count;
} LUPrefix;

LUPrefix* luprefixCreate(int n) {
    LUPrefix* obj = (LUPrefix*)malloc(sizeof(LUPrefix));
    obj->prefix = (int*)calloc(n, sizeof(int));
    obj->size = n;
    obj->count = 0;
    return obj;
}

void luprefixUpload(LUPrefix* obj, int video) {
    obj->prefix[video - 1] = 1;
    while (obj->count < obj->size && obj->prefix[obj->count] == 1) {
        obj->count++;
    }
}

int luprefixLatest(LUPrefix* obj) {
    return obj->count;
}

void luprefixFree(LUPrefix* obj) {
    free(obj->prefix);
    free(obj);
}