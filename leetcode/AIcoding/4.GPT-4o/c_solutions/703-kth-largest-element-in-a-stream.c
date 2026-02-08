#include <stdio.h>
#include <stdlib.h>

struct KthLargest {
    int k;
    int* nums;
    int size;
};

struct KthLargest* kthLargestCreate(int k, int* nums, int numsSize) {
    struct KthLargest* obj = (struct KthLargest*)malloc(sizeof(struct KthLargest));
    obj->k = k;
    obj->size = 0;
    obj->nums = (int*)malloc(sizeof(int) * (numsSize + 1));

    for (int i = 0; i < numsSize; i++) {
        obj->nums[obj->size++] = nums[i];
    }

    qsort(obj->nums, obj->size, sizeof(int), cmp);
    return obj;
}

int kthLargestAdd(struct KthLargest* obj, int val) {
    obj->nums[obj->size++] = val;
    qsort(obj->nums, obj->size, sizeof(int), cmp);
    return obj->nums[obj->size - obj->k];
}

void kthLargestFree(struct KthLargest* obj) {
    free(obj->nums);
    free(obj);
}

int cmp(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}