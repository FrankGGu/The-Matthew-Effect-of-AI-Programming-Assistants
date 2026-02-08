#include <stdlib.h> // For malloc, free

typedef struct {
    int val;
    int count;
} Element;

void swap(Element* a, Element* b) {
    Element temp = *a;
    *a = *b;
    *b = temp;
}

int parent(int i) { return (i - 1) / 2; }
int leftChild(int i) { return 2 * i + 1; }
int rightChild(int i) { return 2 * i + 2; }

void heapifyUp(Element* heap, int idx) {
    while (idx > 0 && heap[idx].count < heap[parent(idx)].count) {
        swap(&heap[idx], &heap[parent(idx)]);
        idx = parent(idx);
    }
}

void heapifyDown(Element* heap, int size, int idx) {
    int smallest = idx;
    int left = leftChild(idx);
    int right = rightChild(idx);

    if (left < size && heap[left].count < heap[smallest].count) {
        smallest = left;
    }
    if (right < size && heap[right].count < heap[smallest].count) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap[idx], &heap[smallest]);
        heapifyDown(heap, size, smallest);
    }
}

void pushHeap(Element* heap, int* heapSizePtr, int k_limit, Element e) {
    if (*heapSizePtr < k_limit) {
        heap[*heapSizePtr] = e;
        (*heapSizePtr)++;
        heapifyUp(heap, *heapSizePtr - 1);
    } else if (e.count > heap[0].count) {
        heap[0] = e;
        heapifyDown(heap, *heapSizePtr, 0);
    }
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    #define OFFSET 10000
    #define MAX_VAL_RANGE 20001

    int counts[MAX_VAL_RANGE] = {0};
    int uniqueVals[MAX_VAL_RANGE];
    int uniqueCount = 0;

    for (int i = 0; i < numsSize; ++i) {
        int index = nums[i] + OFFSET;
        if (counts[index] == 0) {
            uniqueVals[uniqueCount++] = nums[i];
        }
        counts[index]++;
    }

    Element* elements = (Element*)malloc(uniqueCount * sizeof(Element));
    for (int i = 0; i < uniqueCount; ++i) {
        elements[i].val = uniqueVals[i];
        elements[i].count = counts[uniqueVals[i] + OFFSET];
    }

    Element* minHeap = (Element*)malloc(k * sizeof(Element));
    int heapSize = 0;

    for (int i = 0; i < uniqueCount; ++i) {
        pushHeap(minHeap, &heapSize, k, elements[i]);
    }

    int* result = (int*)malloc(k * sizeof(int));
    for (int i = 0; i < k; ++i) {
        result[i] = minHeap[i].val;
    }

    *returnSize = k;

    free(elements);
    free(minHeap);

    return result;
}