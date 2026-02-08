typedef long long ll;

typedef struct {
    int* heap;
    int size;
    int capacity;
} MinHeap;

MinHeap* createMinHeap(int capacity) {
    MinHeap* minHeap = (MinHeap*)malloc(sizeof(MinHeap));
    minHeap->size = 0;
    minHeap->capacity = capacity;
    minHeap->heap = (int*)malloc(capacity * sizeof(int));
    return minHeap;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void minHeapify(MinHeap* minHeap, int idx) {
    int smallest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < minHeap->size && minHeap->heap[left] < minHeap->heap[smallest])
        smallest = left;

    if (right < minHeap->size && minHeap->heap[right] < minHeap->heap[smallest])
        smallest = right;

    if (smallest != idx) {
        swap(&minHeap->heap[idx], &minHeap->heap[smallest]);
        minHeapify(minHeap, smallest);
    }
}

void push(MinHeap* minHeap, int val) {
    if (minHeap->size == minHeap->capacity) return;

    minHeap->heap[minHeap->size] = val;
    int i = minHeap->size;
    minHeap->size++;

    while (i != 0 && minHeap->heap[(i - 1) / 2] > minHeap->heap[i]) {
        swap(&minHeap->heap[i], &minHeap->heap[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int pop(MinHeap* minHeap) {
    if (minHeap->size <= 0) return -1;
    if (minHeap->size == 1) {
        minHeap->size--;
        return minHeap->heap[0];
    }

    int root = minHeap->heap[0];
    minHeap->heap[0] = minHeap->heap[minHeap->size - 1];
    minHeap->size--;
    minHeapify(minHeap, 0);

    return root;
}

int magicTower(int* nums, int numsSize) {
    ll hp = 1;
    ll sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    if (sum < 0) return -1;

    MinHeap* minHeap = createMinHeap(numsSize);
    int moves = 0;
    ll damage = 0;

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] < 0) {
            push(minHeap, nums[i]);
        }
        hp += nums[i];

        if (hp <= 0) {
            int minVal = pop(minHeap);
            hp -= minVal;
            damage += minVal;
            moves++;
        }
    }

    free(minHeap->heap);
    free(minHeap);

    return moves;
}