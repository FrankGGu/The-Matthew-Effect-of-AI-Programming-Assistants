#include <stdlib.h>

typedef struct {
    int capital;
    int profit;
} Project;

int compareCapital(const void* a, const void* b) {
    return ((Project*)a)->capital - ((Project*)b)->capital;
}

int compareProfit(const void* a, const void* b) {
    return ((Project*)b)->profit - ((Project*)a)->profit;
}

int findMaximizedCapital(int k, int w, int* profits, int* capital, int profitsSize, int* capitalSize) {
    Project* projects = (Project*)malloc(profitsSize * sizeof(Project));
    for (int i = 0; i < profitsSize; i++) {
        projects[i].capital = capital[i];
        projects[i].profit = profits[i];
    }

    qsort(projects, profitsSize, sizeof(Project), compareCapital);

    int* heap = (int*)malloc(profitsSize * sizeof(int));
    int heapSize = 0;

    int idx = 0;
    for (int i = 0; i < k; i++) {
        while (idx < profitsSize && projects[idx].capital <= w) {
            heap[heapSize++] = projects[idx].profit;
            idx++;
            int j = heapSize - 1;
            while (j > 0 && heap[j] > heap[(j - 1) / 2]) {
                int temp = heap[j];
                heap[j] = heap[(j - 1) / 2];
                heap[(j - 1) / 2] = temp;
                j = (j - 1) / 2;
            }
        }

        if (heapSize == 0) {
            break;
        }

        w += heap[0];
        heap[0] = heap[--heapSize];
        int j = 0;
        while (2 * j + 1 < heapSize) {
            int left = 2 * j + 1;
            int right = 2 * j + 2;
            int largest = j;
            if (left < heapSize && heap[left] > heap[largest]) {
                largest = left;
            }
            if (right < heapSize && heap[right] > heap[largest]) {
                largest = right;
            }
            if (largest != j) {
                int temp = heap[j];
                heap[j] = heap[largest];
                heap[largest] = temp;
                j = largest;
            } else {
                break;
            }
        }
    }

    free(projects);
    free(heap);
    return w;
}