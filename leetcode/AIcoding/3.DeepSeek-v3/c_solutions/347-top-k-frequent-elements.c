typedef struct {
    int num;
    int freq;
} NumFreq;

typedef struct {
    NumFreq* heap;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->heap = (NumFreq*)malloc(capacity * sizeof(NumFreq));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    return minHeap;
}

void swap(NumFreq* a, NumFreq* b) {
    NumFreq temp = *a;
    *a = *b;
    *b = temp;
}

void heapifyUp(MinHeap* minHeap, int idx) {
    int parent = (idx - 1) / 2;
    while (idx > 0 && minHeap->heap[parent].freq > minHeap->heap[idx].freq) {
        swap(&minHeap->heap[parent], &minHeap->heap[idx]);
        idx = parent;
        parent = (idx - 1) / 2;
    }
}

void heapifyDown(MinHeap* minHeap, int idx) {
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;
    int smallest = idx;

    if (left < minHeap->size && minHeap->heap[left].freq < minHeap->heap[smallest].freq) {
        smallest = left;
    }

    if (right < minHeap->size && minHeap->heap[right].freq < minHeap->heap[smallest].freq) {
        smallest = right;
    }

    if (smallest != idx) {
        swap(&minHeap->heap[idx], &minHeap->heap[smallest]);
        heapifyDown(minHeap, smallest);
    }
}

void push(MinHeap* minHeap, NumFreq element) {
    if (minHeap->size == minHeap->capacity) {
        if (element.freq > minHeap->heap[0].freq) {
            minHeap->heap[0] = element;
            heapifyDown(minHeap, 0);
        }
    } else {
        minHeap->heap[minHeap->size] = element;
        heapifyUp(minHeap, minHeap->size);
        minHeap->size++;
    }
}

int compare(const void* a, const void* b) {
    return ((NumFreq*)b)->freq - ((NumFreq*)a)->freq;
}

int* topKFrequent(int* nums, int numsSize, int k, int* returnSize) {
    int min = nums[0], max = nums[0];
    for (int i = 1; i < numsSize; i++) {
        if (nums[i] < min) min = nums[i];
        if (nums[i] > max) max = nums[i];
    }

    int range = max - min + 1;
    int* freq = (int*)calloc(range, sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        freq[nums[i] - min]++;
    }

    MinHeap* minHeap = createMinHeap(k);

    for (int i = 0; i < range; i++) {
        if (freq[i] > 0) {
            NumFreq nf;
            nf.num = i + min;
            nf.freq = freq[i];
            push(minHeap, nf);
        }
    }

    free(freq);

    int* result = (int*)malloc(k * sizeof(int));
    *returnSize = k;

    qsort(minHeap->heap, minHeap->size, sizeof(NumFreq), compare);

    for (int i = 0; i < k; i++) {
        result[i] = minHeap->heap[i].num;
    }

    free(minHeap->heap);
    free(minHeap);

    return result;
}