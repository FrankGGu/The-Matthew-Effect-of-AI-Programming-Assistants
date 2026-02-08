int minBuildTime(int* blocks, int blocksSize, int split) {
    int heap[blocksSize + 1];
    int heapSize = 0;

    for (int i = 0; i < blocksSize; i++) {
        heap[heapSize++] = blocks[i];
        int current = heapSize - 1;
        while (current > 0) {
            int parent = (current - 1) / 2;
            if (heap[parent] >= heap[current]) break;
            int temp = heap[parent];
            heap[parent] = heap[current];
            heap[current] = temp;
            current = parent;
        }
    }

    while (heapSize > 1) {
        int x = heap[0];
        heap[0] = heap[--heapSize];
        int current = 0;
        while (current * 2 + 1 < heapSize) {
            int child = current * 2 + 1;
            if (child + 1 < heapSize && heap[child + 1] > heap[child]) {
                child++;
            }
            if (heap[current] >= heap[child]) break;
            int temp = heap[current];
            heap[current] = heap[child];
            heap[child] = temp;
            current = child;
        }

        int y = heap[0];
        heap[0] = heap[--heapSize];
        current = 0;
        while (current * 2 + 1 < heapSize) {
            int child = current * 2 + 1;
            if (child + 1 < heapSize && heap[child + 1] > heap[child]) {
                child++;
            }
            if (heap[current] >= heap[child]) break;
            int temp = heap[current];
            heap[current] = heap[child];
            heap[child] = temp;
            current = child;
        }

        int newBlock = (x > y ? x : y) + split;
        heap[heapSize++] = newBlock;
        current = heapSize - 1;
        while (current > 0) {
            int parent = (current - 1) / 2;
            if (heap[parent] >= heap[current]) break;
            int temp = heap[parent];
            heap[parent] = heap[current];
            heap[current] = temp;
            current = parent;
        }
    }

    return heap[0];
}