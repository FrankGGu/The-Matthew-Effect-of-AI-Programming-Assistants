#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    bool* uploaded;
    int n;
    int longest_prefix;
} LUPrefix;

LUPrefix* luprefixCreate(int n) {
    LUPrefix* obj = (LUPrefix*)malloc(sizeof(LUPrefix));
    obj->n = n;
    obj->uploaded = (bool*)calloc(n + 1, sizeof(bool));
    obj->longest_prefix = 0;
    return obj;
}

void luprefixUpload(LUPrefix* obj, int video) {
    obj->uploaded[video] = true;
    while (obj->longest_prefix + 1 <= obj->n && obj->uploaded[obj->longest_prefix + 1]) {
        obj->longest_prefix++;
    }
}

int luprefixLongest(LUPrefix* obj) {
    return obj->longest_prefix;
}

void luprefixFree(LUPrefix* obj) {
    free(obj->uploaded);
    free(obj);
}