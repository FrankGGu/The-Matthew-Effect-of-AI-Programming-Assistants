typedef struct {
    int* heap;
    int size;
    int capacity;
} MaxHeap;

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MaxHeap* maxHeap, int idx) {
    while (idx > 0) {
        int parent = (idx - 1) / 2;
        if (maxHeap->heap[parent] >= maxHeap->heap[idx]) break;
        swap(&maxHeap->heap[parent], &maxHeap->heap[idx]);
        idx = parent;
    }
}

void heapifyDown(MaxHeap* maxHeap, int idx) {
    while (1) {
        int left = 2 * idx + 1;
        int right = 2 * idx + 2;
        int largest = idx;

        if (left < maxHeap->size && maxHeap->heap[left] > maxHeap->heap[largest]) {
            largest = left;
        }
        if (right < maxHeap->size && maxHeap->heap[right] > maxHeap->heap[largest]) {
            largest = right;
        }
        if (largest == idx) break;

        swap(&maxHeap->heap[idx], &maxHeap->heap[largest]);
        idx = largest;
    }
}

void push(MaxHeap* maxHeap, int val) {
    if (maxHeap->size == maxHeap->capacity) {
        maxHeap->capacity *= 2;
        maxHeap->heap = realloc(maxHeap->heap, maxHeap->capacity * sizeof(int));
    }
    maxHeap->heap[maxHeap->size] = val;
    heapifyUp(maxHeap, maxHeap->size);
    maxHeap->size++;
}

int pop(MaxHeap* maxHeap) {
    if (maxHeap->size == 0) return -1;
    int maxVal = maxHeap->heap[0];
    maxHeap->heap[0] = maxHeap->heap[maxHeap->size - 1];
    maxHeap->size--;
    heapifyDown(maxHeap, 0);
    return maxVal;
}

int lastStoneWeight(int* stones, int stonesSize) {
    MaxHeap maxHeap;
    maxHeap.capacity = stonesSize;
    maxHeap.size = 0;
    maxHeap.heap = malloc(maxHeap.capacity * sizeof(int));

    for (int i = 0; i < stonesSize; i++) {
        push(&maxHeap, stones[i]);
    }

    while (maxHeap.size > 1) {
        int y = pop(&maxHeap);
        int x = pop(&maxHeap);
        if (x != y) {
            push(&maxHeap, y - x);
        }
    }

    int result = maxHeap.size == 0 ? 0 : pop(&maxHeap);
    free(maxHeap.heap);
    return result;
}