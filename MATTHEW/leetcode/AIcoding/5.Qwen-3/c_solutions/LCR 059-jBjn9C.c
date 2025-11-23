#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* heap;
    int capacity;
    int size;
    int k;
} KthLargest;

KthLargest* kthLargestCreate(int k, int* nums, int numsSize) {
    KthLargest* obj = (KthLargest*)malloc(sizeof(KthLargest));
    obj->k = k;
    obj->capacity = k;
    obj->heap = (int*)malloc(k * sizeof(int));
    obj->size = 0;

    for (int i = 0; i < numsSize; i++) {
        if (obj->size < k) {
            obj->heap[obj->size++] = nums[i];
            int idx = obj->size - 1;
            while (idx > 0) {
                int parent = (idx - 1) / 2;
                if (obj->heap[parent] > obj->heap[idx]) {
                    int temp = obj->heap[parent];
                    obj->heap[parent] = obj->heap[idx];
                    obj->heap[idx] = temp;
                    idx = parent;
                } else {
                    break;
                }
            }
        } else {
            if (nums[i] > obj->heap[0]) {
                obj->heap[0] = nums[i];
                int idx = 0;
                while (1) {
                    int left = 2 * idx + 1;
                    int right = 2 * idx + 2;
                    int smallest = idx;
                    if (left < k && obj->heap[left] < obj->heap[smallest]) {
                        smallest = left;
                    }
                    if (right < k && obj->heap[right] < obj->heap[smallest]) {
                        smallest = right;
                    }
                    if (smallest != idx) {
                        int temp = obj->heap[smallest];
                        obj->heap[smallest] = obj->heap[idx];
                        obj->heap[idx] = temp;
                        idx = smallest;
                    } else {
                        break;
                    }
                }
            }
        }
    }

    return obj;
}

int kthLargestAdd(KthLargest* obj, int val) {
    if (obj->size < obj->k) {
        obj->heap[obj->size++] = val;
        int idx = obj->size - 1;
        while (idx > 0) {
            int parent = (idx - 1) / 2;
            if (obj->heap[parent] > obj->heap[idx]) {
                int temp = obj->heap[parent];
                obj->heap[parent] = obj->heap[idx];
                obj->heap[idx] = temp;
                idx = parent;
            } else {
                break;
            }
        }
    } else {
        if (val > obj->heap[0]) {
            obj->heap[0] = val;
            int idx = 0;
            while (1) {
                int left = 2 * idx + 1;
                int right = 2 * idx + 2;
                int smallest = idx;
                if (left < obj->k && obj->heap[left] < obj->heap[smallest]) {
                    smallest = left;
                }
                if (right < obj->k && obj->heap[right] < obj->heap[smallest]) {
                    smallest = right;
                }
                if (smallest != idx) {
                    int temp = obj->heap[smallest];
                    obj->heap[smallest] = obj->heap[idx];
                    obj->heap[idx] = temp;
                    idx = smallest;
                } else {
                    break;
                }
            }
        }
    }
    return obj->heap[0];
}

void kthLargestFree(KthLargest* obj) {
    free(obj->heap);
    free(obj);
}