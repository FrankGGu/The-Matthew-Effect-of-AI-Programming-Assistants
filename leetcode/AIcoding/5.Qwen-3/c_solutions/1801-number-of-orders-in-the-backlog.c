#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int price;
    long long quantity;
} Order;

typedef struct {
    Order* data;
    int size;
} MaxHeap;

typedef struct {
    Order* data;
    int size;
} MinHeap;

void swap(Order* a, Order* b) {
    Order t = *a;
    *a = *b;
    *b = t;
}

void maxHeapify(MaxHeap* heap, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < heap->size && heap->data[left].price > heap->data[largest].price)
        largest = left;
    if (right < heap->size && heap->data[right].price > heap->data[largest].price)
        largest = right;

    if (largest != i) {
        swap(&heap->data[i], &heap->data[largest]);
        maxHeapify(heap, largest);
    }
}

void minHeapify(MinHeap* heap, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < heap->size && heap->data[left].price < heap->data[smallest].price)
        smallest = left;
    if (right < heap->size && heap->data[right].price < heap->data[smallest].price)
        smallest = right;

    if (smallest != i) {
        swap(&heap->data[i], &heap->data[smallest]);
        minHeapify(heap, smallest);
    }
}

void pushMaxHeap(MaxHeap* heap, Order order) {
    heap->data[heap->size++] = order;
    int i = heap->size - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[i].price <= heap->data[parent].price) break;
        swap(&heap->data[i], &heap->data[parent]);
        i = parent;
    }
}

void pushMinHeap(MinHeap* heap, Order order) {
    heap->data[heap->size++] = order;
    int i = heap->size - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (heap->data[i].price >= heap->data[parent].price) break;
        swap(&heap->data[i], &heap->data[parent]);
        i = parent;
    }
}

Order popMaxHeap(MaxHeap* heap) {
    Order root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    maxHeapify(heap, 0);
    return root;
}

Order popMinHeap(MinHeap* heap) {
    Order root = heap->data[0];
    heap->data[0] = heap->data[--heap->size];
    minHeapify(heap, 0);
    return root;
}

int compare(const void* a, const void* b) {
    return ((Order*)b)->price - ((Order*)a)->price;
}

long long numberofBacklogTickets(int** orders, int ordersSize, int* ordersColSize) {
    MaxHeap buyHeap;
    buyHeap.data = (Order*)malloc(ordersSize * sizeof(Order));
    buyHeap.size = 0;

    MinHeap sellHeap;
    sellHeap.data = (Order*)malloc(ordersSize * sizeof(Order));
    sellHeap.size = 0;

    for (int i = 0; i < ordersSize; i++) {
        int price = orders[i][0];
        long long quantity = orders[i][1];
        int type = orders[i][2];

        if (type == 0) {
            while (quantity > 0 && sellHeap.size > 0 && sellHeap.data[0].price <= price) {
                Order sell = popMinHeap(&sellHeap);
                if (sell.quantity <= quantity) {
                    quantity -= sell.quantity;
                } else {
                    sell.quantity -= quantity;
                    pushMinHeap(&sellHeap, sell);
                    quantity = 0;
                }
            }
            if (quantity > 0) {
                Order buy = {price, quantity};
                pushMaxHeap(&buyHeap, buy);
            }
        } else {
            while (quantity > 0 && buyHeap.size > 0 && buyHeap.data[0].price >= price) {
                Order buy = popMaxHeap(&buyHeap);
                if (buy.quantity <= quantity) {
                    quantity -= buy.quantity;
                } else {
                    buy.quantity -= quantity;
                    pushMaxHeap(&buyHeap, buy);
                    quantity = 0;
                }
            }
            if (quantity > 0) {
                Order sell = {price, quantity};
                pushMinHeap(&sellHeap, sell);
            }
        }
    }

    long long total = 0;
    for (int i = 0; i < buyHeap.size; i++) {
        total += buyHeap.data[i].quantity;
    }
    for (int i = 0; i < sellHeap.size; i++) {
        total += sellHeap.data[i].quantity;
    }

    free(buyHeap.data);
    free(sellHeap.data);

    return total;
}