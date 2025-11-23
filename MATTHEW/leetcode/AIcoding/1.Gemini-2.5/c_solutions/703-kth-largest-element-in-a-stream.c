#include <stdlib.h>
#include <stdbool.h>

static void _swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

static void _heapify_up(int* heap, int index) {
    while (index > 0 && heap[(index - 1) / 2] > heap[index]) {
        _swap(&heap[index], &heap[(index - 1) / 2]);
        index = (index - 1) / 2;
    }
}

static void _heapify_down(int* heap, int size, int index) {
    while (true) {
        int left_child = 2 * index + 1;
        int right_child = 2 * index + 2;
        int smallest = index;

        if (left_child < size && heap[left_child] < heap[smallest]) {
            smallest = left_child;
        }
        if (right_child < size && heap[right_child] < heap[smallest]) {
            smallest = right_child;
        }

        if (smallest != index) {
            _swap(&heap[index], &heap[smallest]);
            index = smallest;
        } else {
            break;
        }
    }
}

typedef struct {
    int k;
    int* heap;
    int size; // Current number of elements in the heap
} KthLargest;

KthLargest* kthLargestCreate(int k, int* nums, int numsSize) {
    KthLargest* obj = (KthLargest*)malloc(sizeof(KthLargest));
    obj->k = k;
    obj->heap = (int*)malloc(sizeof(int) * k); // Heap will store at most k elements
    obj->size = 0;

    // Populate the initial heap with elements from nums
    // The kthLargestAdd function handles the logic of keeping only the k largest
    for (int i = 0; i < numsSize; i++) {
        // We call the add function directly to ensure the heap property is maintained
        // and only the k largest elements are kept.
        kthLargestAdd(obj, nums[i]);
    }

    return obj;
}

int kthLargestAdd(KthLargest* obj, int val) {
    if (obj->size < obj->k) {
        // Heap is not yet full, just add the element and heapify up
        obj->heap[obj->size] = val;
        obj->size++;
        _heapify_up(obj->heap, obj->size - 1);
    } else if (val > obj->heap[0]) {
        // Heap is full and the new value is larger than the smallest element in the heap
        // Replace the smallest element (root) and heapify down
        obj->heap[0] = val;
        _heapify_down(obj->heap, obj->size, 0);
    }
    // If heap is full and val <= obj->heap[0], the new value is not among the k largest,
    // so we do nothing.

    return obj->heap[0]; // The root of the min-heap is the Kth largest element
}

void kthLargestFree(KthLargest* obj) {
    free(obj->heap);
    free(obj);
}