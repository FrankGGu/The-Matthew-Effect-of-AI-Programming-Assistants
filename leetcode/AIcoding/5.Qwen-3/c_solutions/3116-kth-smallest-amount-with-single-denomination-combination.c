#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int* data;
    int size;
} Heap;

void swap(int* a, int* b) {
    int t = *a;
    *a = *b;
    *b = t;
}

void heapify(Heap* h, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < h->size && h->data[left] < h->data[smallest])
        smallest = left;

    if (right < h->size && h->data[right] < h->data[smallest])
        smallest = right;

    if (smallest != i) {
        swap(&h->data[i], &h->data[smallest]);
        heapify(h, smallest);
    }
}

void push(Heap* h, int value) {
    h->data = realloc(h->data, (h->size + 1) * sizeof(int));
    h->data[h->size++] = value;
    int i = h->size - 1;
    while (i > 0 && h->data[(i - 1) / 2] > h->data[i]) {
        swap(&h->data[i], &h->data[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int pop(Heap* h) {
    if (h->size == 0)
        return -1;
    int root = h->data[0];
    h->data[0] = h->data[h->size - 1];
    h->size--;
    heapify(h, 0);
    return root;
}

int kthSmallest(int* coins, int coinsSize, int k) {
    Heap h;
    h.data = NULL;
    h.size = 0;

    for (int i = 0; i < coinsSize; i++) {
        push(&h, coins[i]);
    }

    int result = 0;
    for (int i = 0; i < k; i++) {
        result = pop(&h);
    }

    return result;
}