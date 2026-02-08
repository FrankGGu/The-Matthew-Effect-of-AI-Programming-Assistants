#include <stdlib.h> // For malloc, free

typedef struct {
    int val;
    int row;
    int col;
} HeapNode;

HeapNode* heap_arr;
int heap_size_global;
int heap_capacity_global;

void swap(HeapNode* a, HeapNode* b) {
    HeapNode temp = *a;
    *a = *b;
    *b = temp;
}

void heapify_down(int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap_size_global && heap_arr[left].val < heap_arr[smallest].val) {
        smallest = left;
    }
    if (right < heap_size_global && heap_arr[right].val < heap_arr[smallest].val) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&heap_arr[idx], &heap_arr[smallest]);
        heapify_down(smallest);
    }
}

void heapify_up(int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && heap_arr[idx].val < heap_arr[parent].val) {
        swap(&heap_arr[idx], &heap_arr[parent]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heap_push(HeapNode node) {
    // In this problem, heap_capacity_global is fixed to N and we never exceed it.
    // So, no need for realloc.
    heap_arr[heap_size_global++] = node;
    heapify_up(heap_size_global - 1);
}

HeapNode heap_pop() {
    HeapNode root = heap_arr[0];
    heap_arr[0] = heap_arr[--heap_size_global];
    heapify_down(0);
    return root;
}

HeapNode heap_peek() {
    return heap_arr[0];
}

int kthSmallest(int** matrix, int matrixSize, int* matrixColSize, int k) {
    int n = matrixSize;

    // Initialize global heap variables
    heap_capacity_global = n; // The heap will store at most 'n' elements (one from each row)
    heap_arr = (HeapNode*)malloc(sizeof(HeapNode) * heap_capacity_global);
    heap_size_global = 0;

    // Push the first element of each row into the min-heap
    // Each element stores its value, row index, and column index
    for (int i = 0; i < n; i++) {
        heap_push((HeapNode){matrix[i][0], i, 0});
    }

    // Extract the minimum element k-1 times
    // Each time, if there's a next element in the same row, push it to the heap
    for (int i = 0; i < k - 1; i++) {
        HeapNode current = heap_pop();
        // If there's a next element in the current row, push it to the heap
        if (current.col + 1 < n) {
            heap_push((HeapNode){matrix[current.row][current.col + 1], current.row, current.col + 1});
        }
    }

    // After k-1 extractions, the root of the heap holds the Kth smallest element
    int result = heap_peek().val;

    // Free the allocated memory for the heap
    free(heap_arr);

    return result;
}