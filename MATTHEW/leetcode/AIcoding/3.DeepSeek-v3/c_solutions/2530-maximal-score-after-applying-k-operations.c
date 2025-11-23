typedef long long ll;

void swap(ll* a, ll* b) {
    ll t = *a;
    *a = *b;
    *b = t;
}

void maxHeapify(ll* heap, int size, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left] > heap[largest])
        largest = left;
    if (right < size && heap[right] > heap[largest])
        largest = right;

    if (largest != i) {
        swap(&heap[i], &heap[largest]);
        maxHeapify(heap, size, largest);
    }
}

void buildMaxHeap(ll* heap, int size) {
    for (int i = size / 2 - 1; i >= 0; i--)
        maxHeapify(heap, size, i);
}

long long maxKelements(int* nums, int numsSize, int k) {
    ll* heap = (ll*)malloc(numsSize * sizeof(ll));
    for (int i = 0; i < numsSize; i++)
        heap[i] = nums[i];

    buildMaxHeap(heap, numsSize);
    ll score = 0;
    int heapSize = numsSize;

    for (int i = 0; i < k; i++) {
        score += heap[0];
        heap[0] = (heap[0] + 2) / 3;
        maxHeapify(heap, heapSize, 0);
    }

    free(heap);
    return score;
}