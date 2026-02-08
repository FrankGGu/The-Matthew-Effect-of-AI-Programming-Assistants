#include <stdio.h>
#include <stdlib.h>
#include <math.h>

typedef struct {
    int* data;
    int size;
    int capacity;
} Heap;

Heap* createHeap(int capacity) {
    Heap* h = (Heap*)malloc(sizeof(Heap));
    h->data = (int*)malloc(capacity * sizeof(int));
    h->size = 0;
    h->capacity = capacity;
    return h;
}

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapifyUp(Heap* h, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (h->data[parent] <= h->data[index]) break;
        swap(&h->data[parent], &h->data[index]);
        index = parent;
    }
}

void heapifyDown(Heap* h, int index) {
    int smallest = index;
    int left = 2 * index + 1;
    int right = 2 * index + 2;

    if (left < h->size && h->data[left] < h->data[smallest])
        smallest = left;
    if (right < h->size && h->data[right] < h->data[smallest])
        smallest = right;

    if (smallest != index) {
        swap(&h->data[index], &h->data[smallest]);
        heapifyDown(h, smallest);
    }
}

void insert(Heap* h, int value) {
    if (h->size == h->capacity) {
        h->capacity *= 2;
        h->data = (int*)realloc(h->data, h->capacity * sizeof(int));
    }
    h->data[h->size++] = value;
    heapifyUp(h, h->size - 1);
}

int extractMin(Heap* h) {
    if (h->size == 0) return INT_MIN;
    int min = h->data[0];
    h->data[0] = h->data[--h->size];
    heapifyDown(h, 0);
    return min;
}

void removeElement(Heap* h, int value) {
    for (int i = 0; i < h->size; i++) {
        if (h->data[i] == value) {
            h->data[i] = h->data[--h->size];
            heapifyDown(h, i);
            return;
        }
    }
}

int getMin(Heap* h) {
    return h->size > 0 ? h->data[0] : INT_MIN;
}

int getMedian(int* nums, int n, int k) {
    int* result = (int*)malloc((n - k + 1) * sizeof(int));
    int resIndex = 0;

    Heap* lower = createHeap(k);
    Heap* upper = createHeap(k);

    for (int i = 0; i < k; i++) {
        insert(lower, nums[i]);
    }

    for (int i = 0; i < k / 2; i++) {
        int val = extractMin(lower);
        insert(upper, val);
    }

    for (int i = k; i < n; i++) {
        int num = nums[i];
        int last = nums[i - k];

        if (num <= getMin(lower)) {
            insert(lower, num);
        } else {
            insert(upper, num);
        }

        if (last <= getMin(lower)) {
            removeElement(lower, last);
        } else {
            removeElement(upper, last);
        }

        while (lower->size > upper->size + 1) {
            int val = extractMin(lower);
            insert(upper, val);
        }

        while (upper->size > lower->size) {
            int val = extractMin(upper);
            insert(lower, val);
        }

        result[resIndex++] = (lower->size == upper->size) ? (getMin(lower) + getMin(upper)) / 2 : getMin(lower);
    }

    return resIndex;
}

int* medianSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    int* result = (int*)malloc((*returnSize) * sizeof(int));
    int resIndex = 0;

    Heap* lower = createHeap(k);
    Heap* upper = createHeap(k);

    for (int i = 0; i < k; i++) {
        insert(lower, nums[i]);
    }

    for (int i = 0; i < k / 2; i++) {
        int val = extractMin(lower);
        insert(upper, val);
    }

    for (int i = k; i < numsSize; i++) {
        int num = nums[i];
        int last = nums[i - k];

        if (num <= getMin(lower)) {
            insert(lower, num);
        } else {
            insert(upper, num);
        }

        if (last <= getMin(lower)) {
            removeElement(lower, last);
        } else {
            removeElement(upper, last);
        }

        while (lower->size > upper->size + 1) {
            int val = extractMin(lower);
            insert(upper, val);
        }

        while (upper->size > lower->size) {
            int val = extractMin(upper);
            insert(lower, val);
        }

        result[resIndex++] = (lower->size == upper->size) ? (getMin(lower) + getMin(upper)) / 2 : getMin(lower);
    }

    return result;
}