#include <stdio.h>
#include <stdlib.h>

struct SmallestInfiniteSet {
    int *nums;
    int size;
    int capacity;
    int next;
};

struct SmallestInfiniteSet* smallestInfiniteSetCreate() {
    struct SmallestInfiniteSet* obj = (struct SmallestInfiniteSet*)malloc(sizeof(struct SmallestInfiniteSet));
    obj->nums = (int*)malloc(sizeof(int) * 1000);
    obj->size = 0;
    obj->capacity = 1000;
    obj->next = 1;
    return obj;
}

int smallestInfiniteSetPopSmallest(struct SmallestInfiniteSet* obj) {
    if (obj->size > 0) {
        return obj->nums[--obj->size];
    }
    return obj->next++;
}

void smallestInfiniteSetAddBack(struct SmallestInfiniteSet* obj, int num) {
    if (num < obj->next) {
        if (obj->size == obj->capacity) {
            obj->capacity *= 2;
            obj->nums = (int*)realloc(obj->nums, sizeof(int) * obj->capacity);
        }
        obj->nums[obj->size++] = num;
    }
}

void smallestInfiniteSetFree(struct SmallestInfiniteSet* obj) {
    free(obj->nums);
    free(obj);
}