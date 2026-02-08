#include <stdlib.h>
#include <stdbool.h>

typedef struct {
    int value;
    int original_index;
} Element;

typedef struct {
    Element* data;
    int capacity;
    int size;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* heap = (MinHeap*)malloc(sizeof(MinHeap));
    heap->data = (Element*)malloc(sizeof(Element) * capacity);
    heap->capacity = capacity;
    heap->size = 0;
    return heap;
}

void swap(Element* a, Element* b) {
    Element temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* heap, int index) {
    int parent = (index - 1) / 2;
    while (index > 0 && heap->data[index].value < heap->data[parent].value) {
        swap(&heap->data[index], &heap->data[parent]);
        index = parent;
        parent = (index - 1) / 2;
    }
}

void heapifyDown(MinHeap* heap, int index) {
    int leftChild = 2 * index + 1;
    int rightChild = 2 * index + 2;
    int smallest = index;

    if (leftChild < heap->size && heap->data[leftChild].value < heap->data[smallest].value) {
        smallest = leftChild;
    }
    if (rightChild < heap->size && heap->data[rightChild].value < heap->data[smallest].value) {
        smallest = rightChild;
    }

    if (smallest != index) {
        swap(&heap->data[index], &heap->data[smallest]);
        heapifyDown(heap, smallest);
    }
}

void insertMinHeap(MinHeap* heap, Element element) {
    heap->data[heap->size] = element;
    heapifyUp(heap, heap->size);
    heap->size++;
}

Element extractMin(MinHeap* heap) {
    Element minElement = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapifyDown(heap, 0);
    return minElement;
}

bool isMinHeapEmpty(MinHeap* heap) {
    return heap->size == 0;
}

void freeMinHeap(MinHeap* heap) {
    free(heap->data);
    free(heap);
}

long long* markElements(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    long long* ans = (long long*)malloc(sizeof(long long) * queriesSize);
    *returnSize = queriesSize;

    MinHeap* heap = createMinHeap(numsSize);
    for (int i = 0; i < numsSize; i++) {
        insertMinHeap(heap, (Element){nums[i], i});
    }

    bool* is_marked = (bool*)calloc(numsSize, sizeof(bool));

    long long current_total_sum = 0;

    for (int q_idx = 0; q_idx < queriesSize; q_idx++) {
        int index_to_mark = queries[q_idx][0];
        int k = queries[q_idx][1];

        if (!is_marked[index_to_mark]) {
            current_total_sum += nums[index_to_mark];
            is_marked[index_to_mark] = true;
        }

        int marked_count_in_query = 0;
        while (marked_count_in_query < k && !isMinHeapEmpty(heap)) {
            Element min_el = extractMin(heap);

            if (is_marked[min_el.original_index]) {
                continue;
            }

            current_total_sum += min_el.value;
            is_marked[min_el.original_index] = true;
            marked_count_in_query++;
        }

        ans[q_idx] = current_total_sum;
    }

    freeMinHeap(heap);
    free(is_marked);

    return ans;
}