#include <stdlib.h> // For malloc, free, qsort

typedef struct {
    int n1;
    int n2;
} Pair;

int comparePairs(const void *a, const void *b) {
    return ((Pair *)b)->n2 - ((Pair *)a)->n2;
}

typedef struct {
    int* data;
    int size;
    int capacity;
} MinHeap;

void heap_init(MinHeap* heap, int capacity) {
    heap->data = (int*)malloc(sizeof(int) * capacity);
    heap->size = 0;
    heap->capacity = capacity;
}

void heap_free(MinHeap* heap) {
    free(heap->data);
}

void heapify_up(MinHeap* heap, int idx) {
    while (idx > 0 && heap->data[idx] < heap->data[(idx - 1) / 2]) {
        int parent_idx = (idx - 1) / 2;
        int temp = heap->data[idx];
        heap->data[idx] = heap->data[parent_idx];
        heap->data[parent_idx] = temp;
        idx = parent_idx;
    }
}

void heapify_down(MinHeap* heap, int idx) {
    int left_child = 2 * idx + 1;
    int right_child = 2 * idx + 2;
    int smallest = idx;

    if (left_child < heap->size && heap->data[left_child] < heap->data[smallest]) {
        smallest = left_child;
    }
    if (right_child < heap->size && heap->data[right_child] < heap->data[smallest]) {
        smallest = right_child;
    }

    if (smallest != idx) {
        int temp = heap->data[idx];
        heap->data[idx] = heap->data[smallest];
        heap->data[smallest] = temp;
        heapify_down(heap, smallest);
    }
}

void heap_push(MinHeap* heap, int val) {
    heap->data[heap->size] = val;
    heap->size++;
    heapify_up(heap, heap->size - 1);
}

int heap_pop(MinHeap* heap) {
    int root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapify_down(heap, 0);
    return root;
}

long long maxScore(int* nums1, int nums1Size, int* nums2, int nums2Size, int k) {
    Pair* pairs = (Pair*)malloc(sizeof(Pair) * nums1Size);
    for (int i = 0; i < nums1Size; i++) {
        pairs[i].n1 = nums1[i];
        pairs[i].n2 = nums2[i];
    }

    qsort(pairs, nums1Size, sizeof(Pair), comparePairs);

    MinHeap minHeap;
    heap_init(&minHeap, k);

    long long current_sum_n1 = 0;
    long long max_score = 0;

    for (int i = 0; i < nums1Size; i++) {
        current_sum_n1 += pairs[i].n1;
        heap_push(&minHeap, pairs[i].n1);

        if (minHeap.size > k) {
            current_sum_n1 -= heap_pop(&minHeap);
        }

        if (minHeap.size == k) {
            long long current_product = current_sum_n1 * pairs[i].n2;
            if (current_product > max_score) {
                max_score = current_product;
            }
        }
    }

    free(pairs);
    heap_free(&minHeap);

    return max_score;
}