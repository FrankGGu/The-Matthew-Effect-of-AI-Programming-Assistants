#include <stdio.h>
#include <stdlib.h>

int halveArray(int* nums, int numsSize) {
    double sum = 0.0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }
    double target = sum / 2.0;

    double* heap = (double*)malloc(numsSize * sizeof(double));
    for (int i = 0; i < numsSize; i++) {
        heap[i] = (double)nums[i];
    }

    int size = numsSize;
    for (int i = (size - 1) / 2; i >= 0; i--) {
        int j = i;
        while (j * 2 + 1 < size) {
            int k = j * 2 + 1;
            if (k + 1 < size && heap[k] < heap[k + 1]) {
                k++;
            }
            if (heap[j] >= heap[k]) break;
            double temp = heap[j];
            heap[j] = heap[k];
            heap[k] = temp;
            j = k;
        }
    }

    int operations = 0;
    while (sum > target) {
        double max = heap[0];
        sum -= max;
        max /= 2.0;
        sum += max;
        heap[0] = max;

        int j = 0;
        while (j * 2 + 1 < size) {
            int k = j * 2 + 1;
            if (k + 1 < size && heap[k] < heap[k + 1]) {
                k++;
            }
            if (heap[j] >= heap[k]) break;
            double temp = heap[j];
            heap[j] = heap[k];
            heap[k] = temp;
            j = k;
        }
        operations++;
    }

    free(heap);
    return operations;
}