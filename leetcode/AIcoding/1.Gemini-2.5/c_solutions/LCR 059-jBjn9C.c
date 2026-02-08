#include <stdlib.h> // For malloc, free

typedef struct {
    int* heap;
    int capacity; // K
    int size;     // current number of elements in heap
} KthLargest;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void min_heapify(int* heap, int size, int i) {
    int left = 2 * i + 1;
    int right = 2 * i + 2;
    int smallest = i;

    if (left < size && heap[left] < heap[smallest]) {
        smallest = left;
    }

    if (right < size && heap[right] < heap[smallest]) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        min_heapify(heap, size, smallest);
    }
}

void insert_min_heap(KthLargest* obj, int val) {
    // Add new element to the end
    obj->heap[obj->size] = val;
    obj->size++;

    // Heapify up
    int i = obj->size - 1;
    while (i > 0 && obj->heap[i] < obj->heap[(i - 1) / 2]) {
        swap(&obj->heap[i], &obj->heap[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

KthLargest* KthLargest_init(int k, int* nums, int numsSize) {
    KthLargest* obj = (KthLargest*)malloc(sizeof(KthLargest));
    obj->capacity = k;
    obj->size = 0;
    obj->heap = (int*)malloc(sizeof(int) * k);

    for (int i = 0; i < numsSize; i++) {
        // Use KthLargest_add logic to populate the initial heap
        if (obj->size < obj->capacity) {
            insert_min_heap(obj, nums[i]);
        } else if (nums[i] > obj->heap[0]) {
            obj->heap[0] = nums[i];
            min_heapify(obj->heap, obj->size, 0);
        }
    }
    return obj;
}

int KthLargest_add(KthLargest* obj, int val) {
    if (obj->size < obj->capacity) {
        insert_min_heap(obj, val);
    } else if (val > obj->heap[0]) {
        obj->heap[0] = val;
        min_heapify(obj->heap, obj->size, 0);
    }
    // The Kth largest element is always at the root of the min-heap
    // (or the smallest element if fewer than K elements have been added)
    return obj->heap[0];
}

void KthLargest_free(KthLargest* obj) {
    free(obj->heap);
    free(obj);
}