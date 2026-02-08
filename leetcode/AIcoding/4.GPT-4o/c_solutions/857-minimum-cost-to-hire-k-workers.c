#include <stdio.h>
#include <stdlib.h>

typedef struct {
    double quality;
    int wage;
} Worker;

int cmp(const void *a, const void *b) {
    Worker *workerA = (Worker *)a;
    Worker *workerB = (Worker *)b;
    return (workerA->wage * workerB->quality > workerB->wage * workerA->quality) - (workerA->wage * workerB->quality < workerB->wage * workerA->quality);
}

double minCostToHireWorkers(int* quality, int qualitySize, int* wage, int wageSize, int K) {
    Worker *workers = (Worker *)malloc(qualitySize * sizeof(Worker));
    for (int i = 0; i < qualitySize; i++) {
        workers[i].quality = (double)quality[i];
        workers[i].wage = wage[i];
    }
    qsort(workers, qualitySize, sizeof(Worker), cmp);

    double result = 1e9;
    double totalQuality = 0;
    int heapSize = 0;
    int *heap = (int *)malloc(K * sizeof(int));

    for (int i = 0; i < qualitySize; i++) {
        totalQuality += workers[i].quality;
        heap[heapSize++] = workers[i].quality;

        if (heapSize > K) {
            int maxQualityIndex = 0;
            for (int j = 1; j < heapSize; j++) {
                if (heap[j] > heap[maxQualityIndex]) {
                    maxQualityIndex = j;
                }
            }
            totalQuality -= heap[maxQualityIndex];
            heap[maxQualityIndex] = heap[--heapSize];
        }

        if (heapSize == K) {
            result = fmin(result, totalQuality * workers[i].wage / workers[i].quality);
        }
    }

    free(workers);
    free(heap);
    return result;
}