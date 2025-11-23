#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* heap;
    int size;
    int capacity;
} KthLargest;

int compare(const void* a, const void* b) {
    return (*(int*)a - *(int*)b);
}

KthLargest* kthLargestCreate(int k, int* nums, int numsSize) {
    KthLargest* obj = (KthLargest*)malloc(sizeof(KthLargest));
    obj->capacity = k;
    obj->size = 0;
    obj->heap = (int*)malloc(k * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (obj->size < k) {
            obj->heap[obj->size++] = nums[i];
        } else {
            if (nums[i] > obj->heap[0]) {
                obj->heap[0] = nums[i];
                qsort(obj->heap, k, sizeof(int), compare);
            }
        }
    }

    qsort(obj->heap, k, sizeof(int), compare);
    return obj;
}

int kthLargestAdd(KthLargest* obj, int val) {
    if (obj->size < obj->capacity) {
        obj->heap[obj->size++] = val;
        qsort(obj->heap, obj->size, sizeof(int), compare);
    } else {
        if (val > obj->heap[0]) {
            obj->heap[0] = val;
            qsort(obj->heap, obj->capacity, sizeof(int), compare);
        }
    }
    return obj->heap[0];
}

void kthLargestFree(KthLargest* obj) {
    free(obj->heap);
    free(obj);
}