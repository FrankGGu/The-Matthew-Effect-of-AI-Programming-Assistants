int cmp(const void* a, const void* b) {
    return *(int*)b - *(int*)a;
}

int connectSticks(int* sticks, int sticksSize) {
    if (sticksSize == 1) return 0;

    int totalCost = 0;
    int heapSize = sticksSize;
    int* heap = (int*)malloc(sizeof(int) * sticksSize);
    for (int i = 0; i < sticksSize; i++) {
        heap[i] = sticks[i];
    }

    qsort(heap, heapSize, sizeof(int), cmp);

    while (heapSize > 1) {
        int x = heap[heapSize - 1];
        int y = heap[heapSize - 2];

        int cost = x + y;
        totalCost += cost;

        heapSize--;
        heap[heapSize - 1] = cost;

        for (int i = heapSize - 1; i > 0; i--) {
            if (heap[i] > heap[i - 1]) {
                int temp = heap[i];
                heap[i] = heap[i - 1];
                heap[i - 1] = temp;
            } else {
                break;
            }
        }
    }

    free(heap);
    return totalCost;
}