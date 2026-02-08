int lastStoneWeight(int* stones, int stonesSize) {
    if (stonesSize == 0) return 0;

    // Create a max heap
    int* heap = (int*)malloc(sizeof(int) * stonesSize);
    for (int i = 0; i < stonesSize; i++) {
        heap[i] = stones[i];
    }

    // Build the max heap
    for (int i = stonesSize / 2 - 1; i >= 0; i--) {
        int j = i;
        while (j < stonesSize) {
            int left = 2 * j + 1;
            int right = 2 * j + 2;
            int largest = j;
            if (left < stonesSize && heap[left] > heap[largest]) largest = left;
            if (right < stonesSize && heap[right] > heap[largest]) largest = right;
            if (largest == j) break;
            int temp = heap[j];
            heap[j] = heap[largest];
            heap[largest] = temp;
            j = largest;
        }
    }

    while (stonesSize > 1) {
        int first = heap[0];
        heap[0] = heap[--stonesSize];
        int j = 0;
        while (j < stonesSize) {
            int left = 2 * j + 1;
            int right = 2 * j + 2;
            int largest = j;
            if (left < stonesSize && heap[left] > heap[largest]) largest = left;
            if (right < stonesSize && heap[right] > heap[largest]) largest = right;
            if (largest == j) break;
            int temp = heap[j];
            heap[j] = heap[largest];
            heap[largest] = temp;
            j = largest;
        }

        int second = heap[0];
        heap[0] = heap[--stonesSize];
        j = 0;
        while (j < stonesSize) {
            int left = 2 * j + 1;
            int right = 2 * j + 2;
            int largest = j;
            if (left < stonesSize && heap[left] > heap[largest]) largest = left;
            if (right < stonesSize && heap[right] > heap[largest]) largest = right;
            if (largest == j) break;
            int temp = heap[j];
            heap[j] = heap[largest];
            heap[largest] = temp;
            j = largest;
        }

        if (first != second) {
            heap[stonesSize++] = first - second;
            int k = stonesSize - 1;
            while (k > 0) {
                int parent = (k - 1) / 2;
                if (heap[k] > heap[parent]) {
                    int temp = heap[k];
                    heap[k] = heap[parent];
                    heap[parent] = temp;
                    k = parent;
                } else {
                    break;
                }
            }
        }
    }

    int result = stonesSize == 0 ? 0 : heap[0];
    free(heap);
    return result;
}