typedef struct {
    int* apples;
    int* days;
    int size;
} Heap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(Heap* heap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (heap->days[parent] > heap->days[idx]) {
            swap(&heap->days[parent], &heap->days[idx]);
            swap(&heap->apples[parent], &heap->apples[idx]);
            idx = parent;
        } else {
            break;
        }
    }
}

void heapifyDown(Heap* heap, int idx) {
    int left, right, smallest;
    while (1) {
        left = 2 * idx + 1;
        right = 2 * idx + 2;
        smallest = idx;

        if (left < heap->size && heap->days[left] < heap->days[smallest]) {
            smallest = left;
        }
        if (right < heap->size && heap->days[right] < heap->days[smallest]) {
            smallest = right;
        }
        if (smallest != idx) {
            swap(&heap->days[idx], &heap->days[smallest]);
            swap(&heap->apples[idx], &heap->apples[smallest]);
            idx = smallest;
        } else {
            break;
        }
    }
}

void push(Heap* heap, int apple, int day) {
    heap->apples[heap->size] = apple;
    heap->days[heap->size] = day;
    heap->size++;
    heapifyUp(heap, heap->size - 1);
}

void pop(Heap* heap) {
    heap->size--;
    heap->apples[0] = heap->apples[heap->size];
    heap->days[0] = heap->days[heap->size];
    heapifyDown(heap, 0);
}

int eatenApples(int* apples, int applesSize, int* days, int daysSize) {
    int n = applesSize;
    Heap heap;
    heap.apples = (int*)malloc(20000 * sizeof(int));
    heap.days = (int*)malloc(20000 * sizeof(int));
    heap.size = 0;

    int eaten = 0;
    int i = 0;

    while (i < n || heap.size > 0) {
        if (i < n && apples[i] > 0) {
            push(&heap, apples[i], i + days[i]);
        }

        while (heap.size > 0 && heap.days[0] <= i) {
            pop(&heap);
        }

        if (heap.size > 0) {
            heap.apples[0]--;
            eaten++;
            if (heap.apples[0] == 0) {
                pop(&heap);
            }
        }
        i++;
    }

    free(heap.apples);
    free(heap.days);
    return eaten;
}