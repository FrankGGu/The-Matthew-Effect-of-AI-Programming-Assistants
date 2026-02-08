typedef struct {
    int speed;
    int efficiency;
} Engineer;

int compare(const void* a, const void* b) {
    Engineer* e1 = (Engineer*)a;
    Engineer* e2 = (Engineer*)b;
    return e2->efficiency - e1->efficiency;
}

int compareInt(const void* a, const void* b) {
    return *(int*)a - *(int*)b;
}

int maxPerformance(int n, int* speed, int* efficiency, int k) {
    Engineer* engineers = (Engineer*)malloc(n * sizeof(Engineer));
    for (int i = 0; i < n; i++) {
        engineers[i].speed = speed[i];
        engineers[i].efficiency = efficiency[i];
    }

    qsort(engineers, n, sizeof(Engineer), compare);

    long long sum = 0, res = 0;
    int heap[k], heapSize = 0;

    for (int i = 0; i < n; i++) {
        if (heapSize < k) {
            heap[heapSize++] = engineers[i].speed;
            sum += engineers[i].speed;
            qsort(heap, heapSize, sizeof(int), compareInt);
        } else if (engineers[i].speed > heap[0]) {
            sum = sum - heap[0] + engineers[i].speed;
            heap[0] = engineers[i].speed;
            qsort(heap, heapSize, sizeof(int), compareInt);
        }

        long long performance = sum * engineers[i].efficiency;
        if (performance > res) {
            res = performance;
        }
    }

    free(engineers);
    return res % 1000000007;
}