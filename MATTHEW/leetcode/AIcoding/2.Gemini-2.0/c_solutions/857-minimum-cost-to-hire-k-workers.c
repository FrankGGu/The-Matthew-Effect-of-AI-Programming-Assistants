#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int cmp(const void *a, const void *b) {
    double ratio_a = ((double*)a)[0];
    double ratio_b = ((double*)b)[0];
    if (ratio_a < ratio_b) return -1;
    if (ratio_a > ratio_b) return 1;
    return 0;
}

int cmp_int(const void *a, const void *b) {
    return *(int*)a - *(int*)b;
}

double mincostToHireWorkers(int* quality, int qualitySize, int* wage, int wageSize, int k) {
    double workers[qualitySize][2];
    for (int i = 0; i < qualitySize; i++) {
        workers[i][0] = (double)wage[i] / quality[i];
        workers[i][1] = quality[i];
    }

    qsort(workers, qualitySize, sizeof(workers[0]), cmp);

    double min_cost = -1.0;
    int heap[qualitySize];
    int heap_size = 0;
    double quality_sum = 0.0;

    for (int i = 0; i < qualitySize; i++) {
        int curr_quality = (int)workers[i][1];
        double curr_ratio = workers[i][0];

        heap[heap_size++] = curr_quality;
        quality_sum += curr_quality;

        int j = heap_size - 1;
        while (j > 0 && heap[j] > heap[(j - 1) / 2]) {
            int temp = heap[j];
            heap[j] = heap[(j - 1) / 2];
            heap[(j - 1) / 2] = temp;
            j = (j - 1) / 2;
        }

        if (heap_size > k) {
            int max_quality = heap[0];
            quality_sum -= max_quality;

            heap[0] = heap[--heap_size];

            int index = 0;
            while (1) {
                int left = 2 * index + 1;
                int right = 2 * index + 2;
                int largest = index;

                if (left < heap_size && heap[left] > heap[largest]) {
                    largest = left;
                }

                if (right < heap_size && heap[right] > heap[largest]) {
                    largest = right;
                }

                if (largest != index) {
                    int temp = heap[index];
                    heap[index] = heap[largest];
                    heap[largest] = temp;
                    index = largest;
                } else {
                    break;
                }
            }
        }

        if (heap_size == k) {
            double cost = curr_ratio * quality_sum;
            if (min_cost == -1.0 || cost < min_cost) {
                min_cost = cost;
            }
        }
    }

    return min_cost;
}