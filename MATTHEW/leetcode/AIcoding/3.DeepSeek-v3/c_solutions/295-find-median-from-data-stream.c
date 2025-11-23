typedef struct {
    int* maxHeap;
    int* minHeap;
    int maxSize;
    int minSize;
    int capacity;
} MedianFinder;

MedianFinder* medianFinderCreate() {
    MedianFinder* obj = (MedianFinder*)malloc(sizeof(MedianFinder));
    obj->capacity = 100000;
    obj->maxHeap = (int*)malloc(obj->capacity * sizeof(int));
    obj->minHeap = (int*)malloc(obj->capacity * sizeof(int));
    obj->maxSize = 0;
    obj->minSize = 0;
    return obj;
}

void maxHeapifyUp(int* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap[parent] >= heap[index]) break;
        int temp = heap[parent];
        heap[parent] = heap[index];
        heap[index] = temp;
        index = parent;
    }
}

void minHeapifyUp(int* heap, int index) {
    while (index > 0) {
        int parent = (index - 1) / 2;
        if (heap[parent] <= heap[index]) break;
        int temp = heap[parent];
        heap[parent] = heap[index];
        heap[index] = temp;
        index = parent;
    }
}

void maxHeapifyDown(int* heap, int size, int index) {
    while (2 * index + 1 < size) {
        int left = 2 * index + 1;
        int right = 2 * index + 2;
        int largest = index;
        if (left < size && heap[left] > heap[largest]) largest = left;
        if (right < size && heap[right] > heap[largest]) largest = right;
        if (largest == index) break;
        int temp = heap[index];
        heap[index] = heap[largest];
        heap[largest] = temp;
        index = largest;
    }
}

void minHeapifyDown(int* heap, int size, int index) {
    while (2 * index + 1 < size) {
        int left = 2 * index + 1;
        int right = 2 * index + 2;
        int smallest = index;
        if (left < size && heap[left] < heap[smallest]) smallest = left;
        if (right < size && heap[right] < heap[smallest]) smallest = right;
        if (smallest == index) break;
        int temp = heap[index];
        heap[index] = heap[smallest];
        heap[smallest] = temp;
        index = smallest;
    }
}

void medianFinderAddNum(MedianFinder* obj, int num) {
    if (obj->maxSize == 0 || num <= obj->maxHeap[0]) {
        obj->maxHeap[obj->maxSize] = num;
        maxHeapifyUp(obj->maxHeap, obj->maxSize);
        obj->maxSize++;
    } else {
        obj->minHeap[obj->minSize] = num;
        minHeapifyUp(obj->minHeap, obj->minSize);
        obj->minSize++;
    }

    if (obj->maxSize > obj->minSize + 1) {
        int moved = obj->maxHeap[0];
        obj->maxHeap[0] = obj->maxHeap[obj->maxSize - 1];
        obj->maxSize--;
        maxHeapifyDown(obj->maxHeap, obj->maxSize, 0);

        obj->minHeap[obj->minSize] = moved;
        minHeapifyUp(obj->minHeap, obj->minSize);
        obj->minSize++;
    } else if (obj->minSize > obj->maxSize) {
        int moved = obj->minHeap[0];
        obj->minHeap[0] = obj->minHeap[obj->minSize - 1];
        obj->minSize--;
        minHeapifyDown(obj->minHeap, obj->minSize, 0);

        obj->maxHeap[obj->maxSize] = moved;
        maxHeapifyUp(obj->maxHeap, obj->maxSize);
        obj->maxSize++;
    }
}

double medianFinderFindMedian(MedianFinder* obj) {
    if (obj->maxSize > obj->minSize) {
        return (double)obj->maxHeap[0];
    } else {
        return ((double)obj->maxHeap[0] + (double)obj->minHeap[0]) / 2.0;
    }
}

void medianFinderFree(MedianFinder* obj) {
    free(obj->maxHeap);
    free(obj->minHeap);
    free(obj);
}