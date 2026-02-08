#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int quality;
    int wage;
} Worker;

int compare(const void *a, const void to) {
    Worker *w1 = (Worker *)a;
    Worker *w2 = (Worker *)to;
    return w1->wage * w2->quality - w2->wage * w1->quality;
}

double minCostToHireWorkers(int* quality, int qualitySize, int* wage, int wageSize, int k) {
    int n = qualitySize;
    Worker *workers = (Worker *)malloc(n * sizeof(Worker));
    for (int i = 0; i < n; i++) {
        workers[i].quality = quality[i];
        workers[i].wage = wage[i];
    }

    qsort(workers, n, sizeof(Worker), compare);

    int *heap = (int *)malloc(k * sizeof(int));
    int heapSize = 0;

    double totalQuality = 0.0;
    double minCost = 1e18;

    for (int i = 0; i < n; i++) {
        int q = workers[i].quality;
        double rate = (double)workers[i].wage / q;

        if (heapSize < k) {
            totalQuality += q;
            heap[heapSize++] = q;
            if (heapSize == k) {
                minCost = totalQuality * rate;
            }
        } else {
            if (q < heap[0]) {
                totalQuality -= heap[0];
                totalQuality += q;
                heap[0] = q;
                for (int j = 0; j < heapSize; j++) {
                    int parent = (j - 1) / 2;
                    if (heap[j] < heap[parent]) {
                        int temp = heap[j];
                        heap[j] = heap[parent];
                        heap[parent] = temp;
                    }
                }
            }
            minCost = fmin(minCost, totalQuality * rate);
        }
    }

    free(workers);
    free(heap);
    return minCost;
}