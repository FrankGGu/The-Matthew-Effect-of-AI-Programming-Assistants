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

void maxHeapify(MaxHeap* maxHeap, int idx) {
    int largest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < maxHeap->size && maxHeap->heap[left] > maxHeap->heap[largest])
        largest = left;

    if (right < maxHeap->size && maxHeap->heap[right] > maxHeap->heap[largest])
        largest = right;

    if (largest != idx) {
        swap(&maxHeap->heap[idx], &maxHeap->heap[largest]);
        maxHeapify(maxHeap, largest);
    }
}

int extractMax(MaxHeap* maxHeap) {
    if (maxHeap->size <= 0)
        return -1;

    int max = maxHeap->heap[0];
    maxHeap->heap[0] = maxHeap->heap[maxHeap->size - 1];
    maxHeap->size--;
    maxHeapify(maxHeap, 0);
    return max;
}

void insert(MaxHeap* maxHeap, int key) {
    if (maxHeap->size == maxHeap->capacity)
        return;

    maxHeap->size++;
    int i = maxHeap->size - 1;
    maxHeap->heap[i] = key;

    while (i != 0 && maxHeap->heap[(i - 1) / 2] < maxHeap->heap[i]) {
        swap(&maxHeap->heap[i], &maxHeap->heap[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int minStoneSum(int* piles, int pilesSize, int k) {
    MaxHeap maxHeap;
    maxHeap.capacity = pilesSize;
    maxHeap.size = 0;
    maxHeap.heap = (int*)malloc(pilesSize * sizeof(int));

    int total = 0;
    for (int i = 0; i < pilesSize; i++) {
        insert(&maxHeap, piles[i]);
        total += piles[i];
    }

    for (int i = 0; i < k; i++) {
        int max = extractMax(&maxHeap);
        int remove = max / 2;
        total -= remove;
        insert(&maxHeap, max - remove);
    }

    free(maxHeap.heap);
    return total;
}