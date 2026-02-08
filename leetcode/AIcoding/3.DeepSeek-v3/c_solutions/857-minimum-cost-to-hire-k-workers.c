#include <stdlib.h>
#include <string.h>

typedef struct {
    double ratio;
    int quality;
} Worker;

int cmp(const void* a, const void* b) {
    Worker* w1 = (Worker*)a;
    Worker* w2 = (Worker*)b;
    if (w1->ratio > w2->ratio) return 1;
    if (w1->ratio < w2->ratio) return -1;
    return 0;
}

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify(int* heap, int size, int i) {
    int largest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left] > heap[largest])
        largest = left;
    if (right < size && heap[right] > heap[largest])
        largest = right;
    if (largest != i) {
        swap(&heap[i], &heap[largest]);
        heapify(heap, size, largest);
    }
}

void push(int* heap, int* size, int quality) {
    heap[*size] = quality;
    int i = *size;
    (*size)++;

    while (i > 0 && heap[(i - 1) / 2] < heap[i]) {
        swap(&heap[i], &heap[(i - 1) / 2]);
        i = (i - 1) / 2;
    }
}

int pop(int* heap, int* size) {
    int max = heap[0];
    heap[0] = heap[(*size) - 1];
    (*size)--;
    heapify(heap, *size, 0);
    return max;
}

double mincostToHireWorkers(int* quality, int qualitySize, int* wage, int wageSize, int k) {
    int n = qualitySize;
    Worker* workers = (Worker*)malloc(n * sizeof(Worker));

    for (int i = 0; i < n; i++) {
        workers[i].ratio = (double)wage[i] / quality[i];
        workers[i].quality = quality[i];
    }

    qsort(workers, n, sizeof(Worker), cmp);

    int* heap = (int*)malloc(k * sizeof(int));
    int heapSize = 0;
    int qualitySum = 0;
    double result = 1e18;

    for (int i = 0; i < n; i++) {
        double ratio = workers[i].ratio;
        int q = workers[i].quality;

        if (heapSize < k) {
            push(heap, &heapSize, q);
            qualitySum += q;
        } else {
            if (q < heap[0]) {
                qualitySum -= pop(heap, &heapSize);
                push(heap, &heapSize, q);
                qualitySum += q;
            }
        }

        if (heapSize == k) {
            double cost = ratio * qualitySum;
            if (cost < result) {
                result = cost;
            }
        }
    }

    free(workers);
    free(heap);
    return result;
}