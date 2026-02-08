typedef struct {
    long long *arr;
    int size;
} Heap;

void swap(long long *a, long long *b) {
    long long temp = *a;
    *b = *a;
    *a = temp;
}

void heapify(Heap *h, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < h->size && h->arr[left] < h->arr[smallest])
        smallest = left;
    if (right < h->size && h->arr[right] < h->arr[smallest])
        smallest = right;

    if (smallest != i) {
        long long temp = h->arr[i];
        h->arr[i] = h->arr[smallest];
        h->arr[smallest] = temp;
        heapify(h, smallest);
    }
}

void insert(Heap *h, long long val) {
    h->arr[h->size] = val;
    int i = h->size;
    h->size++;

    while (i > 0 && h->arr[(i - 1) / 2] > h->arr[i]) {
        long long temp = h->arr[i];
        h->arr[i] = h->arr[(i - 1) / 2];
        h->arr[(i - 1) / 2] = temp;
        i = (i - 1) / 2;
    }
}

long long extractMin(Heap *h) {
    if (h->size == 0) return -1;

    long long min = h->arr[0];
    h->arr[0] = h->arr[h->size - 1];
    h->size--;
    heapify(h, 0);

    return min;
}

long long* unmarkedSumArray(int* nums, int numsSize, int** queries, int queriesSize, int* queriesColSize, int* returnSize) {
    *returnSize = queriesSize;
    long long *res = (long long*)malloc(queriesSize * sizeof(long long));
    long long total = 0;

    int *marked = (int*)calloc(numsSize, sizeof(int));

    Heap h;
    h.arr = (long long*)malloc(numsSize * sizeof(long long));
    h.size = 0;

    for (int i = 0; i < numsSize; i++) {
        total += nums[i];
        insert(&h, ((long long)nums[i] << 32) | i);
    }

    for (int i = 0; i < queriesSize; i++) {
        int index = queries[i][0];
        int k = queries[i][1];

        if (!marked[index]) {
            total -= nums[index];
            marked[index] = 1;
        }

        while (k > 0 && h.size > 0) {
            long long val = extractMin(&h);
            int idx = val & 0xFFFFFFFF;
            long long num = val >> 32;

            if (!marked[idx]) {
                total -= nums[idx];
                marked[idx] = 1;
                k--;
            }
        }

        res[i] = total;
    }

    free(marked);
    free(h.arr);
    return res;
}