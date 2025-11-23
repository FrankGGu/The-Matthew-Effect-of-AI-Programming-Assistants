int cmp(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int furthestBuilding(int* heights, int heightsSize, int bricks, int ladders) {
    int* heap = (int*)malloc(ladders * sizeof(int));
    int heapSize = 0;
    int sum = 0;

    for (int i = 0; i < heightsSize - 1; i++) {
        int diff = heights[i + 1] - heights[i];
        if (diff <= 0) continue;

        if (heapSize < ladders) {
            heap[heapSize++] = diff;
            if (heapSize == ladders) {
                qsort(heap, heapSize, sizeof(int), cmp);
            }
        } else {
            if (ladders > 0 && diff < heap[heapSize - 1]) {
                sum += diff;
            } else {
                if (ladders > 0) {
                    sum += heap[heapSize - 1];
                    heap[heapSize - 1] = diff;
                    qsort(heap, heapSize, sizeof(int), cmp);
                } else {
                    sum += diff;
                }
            }

            if (sum > bricks) {
                free(heap);
                return i;
            }
        }
    }

    free(heap);
    return heightsSize - 1;
}