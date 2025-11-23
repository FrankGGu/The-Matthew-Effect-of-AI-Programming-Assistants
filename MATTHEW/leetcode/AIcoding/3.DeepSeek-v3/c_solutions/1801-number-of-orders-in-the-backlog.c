typedef struct {
    int price;
    int amount;
} Order;

typedef struct {
    Order* data;
    int size;
    int capacity;
} Heap;

void swap(Order* a, Order* b) {
    Order temp = *a;
    *a = *b;
    *b = temp;
}

void maxHeapPush(Heap* heap, int price, int amount) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = realloc(heap->data, heap->capacity * sizeof(Order));
    }
    heap->data[heap->size].price = price;
    heap->data[heap->size].amount = amount;
    int i = heap->size;
    heap->size++;
    while (i > 0 && heap->data[(i - 1) / 2].price < heap->data[i].price) {
        swap(&heap->data[(i - 1) / 2], &heap->data[i]);
        i = (i - 1) / 2;
    }
}

Order maxHeapPop(Heap* heap) {
    Order root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    int i = 0;
    while (1) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int largest = i;
        if (left < heap->size && heap->data[left].price > heap->data[largest].price) {
            largest = left;
        }
        if (right < heap->size && heap->data[right].price > heap->data[largest].price) {
            largest = right;
        }
        if (largest != i) {
            swap(&heap->data[i], &heap->data[largest]);
            i = largest;
        } else {
            break;
        }
    }
    return root;
}

void minHeapPush(Heap* heap, int price, int amount) {
    if (heap->size == heap->capacity) {
        heap->capacity *= 2;
        heap->data = realloc(heap->data, heap->capacity * sizeof(Order));
    }
    heap->data[heap->size].price = price;
    heap->data[heap->size].amount = amount;
    int i = heap->size;
    heap->size++;
    while (i > 0 && heap->data[(i - 1) / 2].price > heap->data[i].price) {
        swap(&heap->data[(i - 1) / 2], &heap->data[i]);
        i = (i - 1) / 2;
    }
}

Order minHeapPop(Heap* heap) {
    Order root = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    int i = 0;
    while (1) {
        int left = 2 * i + 1;
        int right = 2 * i + 2;
        int smallest = i;
        if (left < heap->size && heap->data[left].price < heap->data[smallest].price) {
            smallest = left;
        }
        if (right < heap->size && heap->data[right].price < heap->data[smallest].price) {
            smallest = right;
        }
        if (smallest != i) {
            swap(&heap->data[i], &heap->data[smallest]);
            i = smallest;
        } else {
            break;
        }
    }
    return root;
}

int getNumberOfBacklogOrders(int** orders, int ordersSize, int* ordersColSize) {
    Heap buyHeap, sellHeap;
    buyHeap.size = 0;
    buyHeap.capacity = 16;
    buyHeap.data = malloc(buyHeap.capacity * sizeof(Order));
    sellHeap.size = 0;
    sellHeap.capacity = 16;
    sellHeap.data = malloc(sellHeap.capacity * sizeof(Order));

    for (int i = 0; i < ordersSize; i++) {
        int price = orders[i][0];
        int amount = orders[i][1];
        int orderType = orders[i][2];

        if (orderType == 0) {
            while (amount > 0 && sellHeap.size > 0 && sellHeap.data[0].price <= price) {
                Order sellOrder = minHeapPop(&sellHeap);
                int execute = (amount < sellOrder.amount) ? amount : sellOrder.amount;
                amount -= execute;
                sellOrder.amount -= execute;
                if (sellOrder.amount > 0) {
                    minHeapPush(&sellHeap, sellOrder.price, sellOrder.amount);
                }
            }
            if (amount > 0) {
                maxHeapPush(&buyHeap, price, amount);
            }
        } else {
            while (amount > 0 && buyHeap.size > 0 && buyHeap.data[0].price >= price) {
                Order buyOrder = maxHeapPop(&buyHeap);
                int execute = (amount < buyOrder.amount) ? amount : buyOrder.amount;
                amount -= execute;
                buyOrder.amount -= execute;
                if (buyOrder.amount > 0) {
                    maxHeapPush(&buyHeap, buyOrder.price, buyOrder.amount);
                }
            }
            if (amount > 0) {
                minHeapPush(&sellHeap, price, amount);
            }
        }
    }

    long total = 0;
    for (int i = 0; i < buyHeap.size; i++) {
        total += buyHeap.data[i].amount;
    }
    for (int i = 0; i < sellHeap.size; i++) {
        total += sellHeap.data[i].amount;
    }

    free(buyHeap.data);
    free(sellHeap.data);

    return total % 1000000007;
}