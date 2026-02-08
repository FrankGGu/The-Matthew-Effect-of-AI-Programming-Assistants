int minStoneSum(int* piles, int pilesSize, int k) {
    // Create a max heap
    int* heap = (int*)malloc(pilesSize * sizeof(int));
    for (int i = 0; i < pilesSize; i++) {
        heap[i] = piles[i];
    }

    // Build max heap
    for (int i = pilesSize / 2 - 1; i >= 0; i--) {
        heapify(heap, pilesSize, i);
    }

    // Remove stones k times
    for (int i = 0; i < k; i++) {
        int maxStone = heap[0];
        heap[0] = maxStone - maxStone / 2;
        heapify(heap, pilesSize, 0);
    }

    // Calculate the total stones left
    int total = 0;
    for (int i = 0; i < pilesSize; i++) {
        total += heap[i];
    }

    free(heap);
    return total;
}

void heapify(int* heap, int size, int root) {
    int largest = root;
    int left = 2 * root + 1;
    int right = 2 * root + 2;

    if (left < size && heap[left] > heap[largest]) {
        largest = left;
    }
    if (right < size && heap[right] > heap[largest]) {
        largest = right;
    }
    if (largest != root) {
        int temp = heap[root];
        heap[root] = heap[largest];
        heap[largest] = temp;
        heapify(heap, size, largest);
    }
}