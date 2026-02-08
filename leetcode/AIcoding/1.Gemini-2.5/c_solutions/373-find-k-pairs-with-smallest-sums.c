#include <stdlib.h> // For malloc, free

typedef struct {
    int sum;
    int idx1;
    int idx2;
} HeapNode;

typedef struct {
    HeapNode* data;
    int size;
    int capacity;
} MinHeap;

void initMinHeap(MinHeap* heap, int capacity) {
    heap->data = (HeapNode*)malloc(capacity * sizeof(HeapNode));
    heap->size = 0;
    heap->capacity = capacity;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    heap->data = NULL;
    heap->size = 0;
    heap->capacity = 0;
}

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
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
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < heap->size && heap->data[left].sum < heap->data[smallest].sum) {
        smallest = left;
    }
    if (right < heap->size && heap->data[right].sum < heap->data[smallest].sum) {
        smallest = right;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void pushMinHeap(MinHeap* heap, HeapNode node) {
    if (heap->size >= heap->capacity) {
        // Should not happen if capacity is chosen correctly, or reallocate
        return;
    }
    heap->data[heap->size] = node;
    heapifyUp(heap, heap->size);
    heap->size++;
}

HeapNode popMinHeap(MinHeap* heap) {
    HeapNode root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return root;
}

int isEmptyMinHeap(MinHeap* heap) {
    return heap->size == 0;
}

int** kSmallestPairs(int* nums1, int nums1Size, int* nums2, int nums2Size, int k, int* returnSize, int** returnColumnSizes) {
    // Calculate the actual number of pairs to return.
    // k can be larger than the total possible pairs (nums1Size * nums2Size).
    // Use long long for totalPossiblePairs to prevent overflow if nums1Size * nums2Size is large.
    long long totalPossiblePairs = (long long)nums1Size * nums2Size;
    int num_to_return = (k < totalPossiblePairs) ? k : totalPossiblePairs;

    // Handle edge case where no pairs can be formed or k is 0
    if (num_to_return == 0) {
        *returnSize = 0;
        *returnColumnSizes = NULL;
        return NULL;
    }

    // Allocate memory for the result array and column sizes array
    int** result = (int**)malloc(num_to_return * sizeof(int*));
    *returnColumnSizes = (int*)malloc(num_to_return * sizeof(int));
    *returnSize = 0; // Initialize returnSize, will be incremented as pairs are added

    // Initialize min-heap
    // The heap will store at most min(k, nums1Size) elements at any given time,
    // plus one extra slot for a pending push.
    int initialHeapElements = (nums1Size < k) ? nums1Size : k;
    int heapCapacity = initialHeapElements + 1; // +1 for safety
    MinHeap heap;
    initMinHeap(&heap, heapCapacity);

    // Add initial pairs to the heap: (nums1[i], nums2[0]) for i from 0 to min(k-1, nums1Size-1)
    // We only need to consider up to k elements from nums1 initially,
    // as we are looking for the k smallest pairs.
    for (int i = 0; i < nums1Size && i < k; ++i) {
        if (nums2Size > 0) { // Ensure nums2 has at least one element
            HeapNode node = {
                .sum = nums1[i] + nums2[0],
                .idx1 = i,
                .idx2 = 0
            };
            pushMinHeap(&heap, node);
        }
    }

    // Extract k smallest pairs from the heap
    while (*returnSize < num_to_return && !isEmptyMinHeap(&heap)) {
        HeapNode curr = popMinHeap(&heap);

        // Add the current smallest pair to the result
        result[*returnSize] = (int*)malloc(2 * sizeof(int));
        result[*returnSize][0] = nums1[curr.idx1];
        result[*returnSize][1] = nums2[curr.idx2];
        (*returnColumnSizes)[*returnSize] = 2;
        (*returnSize)++;

        // If there's a next element in nums2 for nums1[curr.idx1], push it to heap
        // This ensures we explore all pairs involving nums1[curr.idx1] in increasing sum order
        if (curr.idx2 + 1 < nums2Size) {
            HeapNode nextNode = {
                .sum = nums1[curr.idx1] + nums2[curr.idx2 + 1],
                .idx1 = curr.idx1,
                .idx2 = curr.idx2 + 1
            };
            pushMinHeap(&heap, nextNode);
        }
    }

    // Free the memory allocated for the heap
    freeMinHeap(&heap);

    return result;
}