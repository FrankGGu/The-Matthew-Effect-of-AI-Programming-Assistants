#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int k;
    int *heap;
    int size;
} KthLargest;

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void min_heapify(int *heap, int i, int size) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left] < heap[smallest]) {
        smallest = left;
    }

    if (right < size && heap[right] < heap[smallest]) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        min_heapify(heap, smallest, size);
    }
}

KthLargest* kthLargestCreate(int k, int* nums, int numsSize) {
    KthLargest* obj = (KthLargest*)malloc(sizeof(KthLargest));
    obj->k = k;
    obj->heap = (int*)malloc(k * sizeof(int));
    obj->size = 0;

    for (int i = 0; i < numsSize; i++) {
        if (obj->size < k) {
            obj->heap[obj->size++] = nums[i];
            if (obj->size == k) {
                for (int j = k / 2 - 1; j >= 0; j--) {
                    min_heapify(obj->heap, j, k);
                }
            }
        } else if (nums[i] > obj->heap[0]) {
            obj->heap[0] = nums[i];
            min_heapify(obj->heap, 0, k);
        }
    }

    return obj;
}

int kthLargestAdd(KthLargest* obj, int val) {
    if (obj->size < obj->k) {
        obj->heap[obj->size++] = val;
        if (obj->size == obj->k) {
            for (int j = obj->k / 2 - 1; j >= 0; j--) {
                min_heapify(obj->heap, j, obj->k);
            }
        }
    } else if (val > obj->heap[0]) {
        obj->heap[0] = val;
        min_heapify(obj->heap, 0, obj->k);
    }

    return obj->heap[0];
}

void kthLargestFree(KthLargest* obj) {
    free(obj->heap);
    free(obj);
}