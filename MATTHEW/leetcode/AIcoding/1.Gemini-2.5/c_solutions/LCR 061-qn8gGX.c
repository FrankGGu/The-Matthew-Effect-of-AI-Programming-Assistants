#include <stdlib.h>
#include <stdbool.h>
#include <limits.h>

typedef struct {
    int sum;
    int idx1;
    int idx2;
} PairSum;

typedef struct {
    PairSum* data;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (PairSum*)malloc(sizeof(PairSum) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(PairSum* a, PairSum* b) {
    PairSum temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index].sum < heap->data[parent].sum) {
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int leftChild = 2 * index + 1;
    int rightChild = 2 * index + 2;
    int smallest = index;

    if (leftChild < heap->size && heap->data[leftChild].sum < heap->data[smallest].sum) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && heap->data[rightChild].sum < heap->data[smallest].sum) {
        smallest = rightChild;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void heapPush(MinHeap* heap, PairSum item) {
    if (heap->size == heap->capacity) {
        return;
    }
    heap->data[heap->size] = item;
    heapifyUp(heap, heap->size);
    heap->size++;
}

PairSum heapPop(MinHeap* heap) {
    PairSum root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

bool isHeapEmpty(MinHeap* heap) {
    return heap->size == 0;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    *returnSize = 0;
    if (nums1Size == 0 || nums2Size == 0 || k == 0) {
        *returnColumnSizes = NULL;
        return NULL;
    }

    int heap_capacity = (k < nums1Size) ? k : nums1Size;
    MinHeap* heap = createMinHeap(heap_capacity);

    for (int i = 0; i < nums1Size && i < k; ++i) {
        heapPush(heap, (PairSum){nums1[i] + nums2[0], i, 0});
    }

    int** result = (int**)malloc(sizeof(int*) * k);
    *returnColumnSizes = (int*)malloc(sizeof(int) * k);

    while (*returnSize < k && !isHeapEmpty(heap)) {
        PairSum current = heapPop(heap);

        result[*returnSize] = (int*)malloc(sizeof(int) * 2);
        result[*returnSize][0] = nums1[current.idx1];
        result[*returnSize][1] = nums2[current.idx2];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;

        if (current.idx2 + 1 < nums2Size) {
            heapPush(heap, (PairSum){nums1[current.idx1] + nums2[current.idx2 + 1], current.idx1, current.idx2 + 1});
        }
    }

    freeMinHeap(heap);
    return result;
}