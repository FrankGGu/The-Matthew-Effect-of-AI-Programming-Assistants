#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    bool present[1001];
    int min;
} SmallestInfiniteSet;

SmallestInfiniteSet* smallestInfiniteSetCreate() {
    SmallestInfiniteSet* obj = (SmallestInfiniteSet*)malloc(sizeof(SmallestInfiniteSet));
    for (int i = 1; i <= 1000; i++) {
        obj->present[i] = true;
    }
    obj->min = 1;
    return obj;
}

int smallestInfiniteSetPopSmallest(SmallestInfiniteSet* obj) {
    int num = obj->min;
    obj->present[num] = false;

    for (int i = num + 1; i <= 1000; i++) {
        if (obj->present[i]) {
            obj->min = i;
            break;
        }
    }

    return num;
}

void smallestInfiniteSetAddBack(SmallestInfiniteSet* obj, int num) {
    if (num <= 1000 && !obj->present[num]) {
        obj->present[num] = true;
        if (num < obj->min) {
            obj->min = num;
        }
    }
}

void smallestInfiniteSetFree(SmallestInfiniteSet* obj) {
    free(obj);
}