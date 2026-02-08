typedef struct {
    int *maxHeap;
    int maxSize;
    int maxCount;
    int *minHeap;
    int minSize;
    int minCount;
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder *finder = (MedianFinder *)malloc(sizeof(MedianFinder));
    finder->maxSize = 10000;
    finder->minSize = 10000;
    finder->maxCount = 0;
    finder->minCount = 0;
    finder->maxHeap = (int *)malloc(finder->maxSize * sizeof(int));
    finder->minHeap = (int *)malloc(finder->minSize * sizeof(int));
    return finder;
}

void maxHeapInsert(MedianFinder* obj, int num) {
    obj->maxHeap[obj->maxCount++] = num;
    int i = obj->maxCount - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->maxHeap[parent] >= obj->maxHeap[i]) break;
        int temp = obj->maxHeap[parent];
        obj->maxHeap[parent] = obj->maxHeap[i];
        obj->maxHeap[i] = temp;
        i = parent;
    }
}

void minHeapInsert(MedianFinder* obj, int num) {
    obj->minHeap[obj->minCount++] = num;
    int i = obj->minCount - 1;
    while (i > 0) {
        int parent = (i - 1) / 2;
        if (obj->minHeap[parent] <= obj->minHeap[i]) break;
        int temp = obj->minHeap[parent];
        obj->minHeap[parent] = obj->minHeap[i];
        obj->minHeap[i] = temp;
        i = parent;
    }
}

void balanceHeaps(MedianFinder* obj) {
    while (obj->maxCount > obj->minCount + 1) {
        int root = obj->maxHeap[0];
        obj->maxHeap[0] = obj->maxHeap[--obj->maxCount];
        int i = 0;
        while (i < obj->maxCount) {
            int largest = i;
            if (2 * i + 1 < obj->maxCount && obj->maxHeap[2 * i + 1] > obj->maxHeap[largest])
                largest = 2 * i + 1;
            if (2 * i + 2 < obj->maxCount && obj->maxHeap[2 * i + 2] > obj->maxHeap[largest])
                largest = 2 * i + 2;
            if (largest == i) break;
            int temp = obj->maxHeap[i];
            obj->maxHeap[i] = obj->maxHeap[largest];
            obj->maxHeap[largest] = temp;
            i = largest;
        }
        minHeapInsert(obj, root);
    }

    while (obj->minCount > obj->maxCount) {
        int root = obj->minHeap[0];
        obj->minHeap[0] = obj->minHeap[--obj->minCount];
        int i = 0;
        while (i < obj->minCount) {
            int smallest = i;
            if (2 * i + 1 < obj->minCount && obj->minHeap[2 * i + 1] < obj->minHeap[smallest])
                smallest = 2 * i + 1;
            if (2 * i + 2 < obj->minCount && obj->minHeap[2 * i + 2] < obj->minHeap[smallest])
                smallest = 2 * i + 2;
            if (smallest == i) break;
            int temp = obj->minHeap[i];
            obj->minHeap[i] = obj->minHeap[smallest];
            obj->minHeap[smallest] = temp;
            i = smallest;
        }
        maxHeapInsert(obj, root);
    }
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    if (obj->maxCount == 0 || num <= obj->maxHeap[0]) {
        maxHeapInsert(obj, num);
    } else {
        minHeapInsert(obj, num);
    }
    balanceHeaps(obj);
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->maxCount > obj->minCount) {
        return (double)obj->maxHeap[0];
    } else {
        return (double)(obj->maxHeap[0] + obj->minHeap[0]) / 2.0;
    }
}

void medianFinderFree(MedianFinder* obj) {
    free(obj->maxHeap);
    free(obj->minHeap);
    free(obj);
}