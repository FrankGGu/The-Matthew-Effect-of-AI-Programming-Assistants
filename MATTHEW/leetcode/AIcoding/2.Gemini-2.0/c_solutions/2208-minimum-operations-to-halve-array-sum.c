#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minOperations(int* nums, int numsSize){
    double sum = 0.0;
    for (int i = 0; i < numsSize; i++) {
        sum += (double)nums[i];
    }

    double target = sum / 2.0;

    double *heap = (double*)malloc((numsSize + 1) * sizeof(double));
    int heapSize = 0;

    for (int i = 0; i < numsSize; i++) {
        heap[++heapSize] = (double)nums[i];
    }

    for (int i = heapSize / 2; i >= 1; i--) {
        int j = i;
        while (2 * j <= heapSize) {
            int k = 2 * j;
            if (k + 1 <= heapSize && heap[k + 1] > heap[k]) {
                k++;
            }
            if (heap[j] < heap[k]) {
                double temp = heap[j];
                heap[j] = heap[k];
                heap[k] = temp;
                j = k;
            } else {
                break;
            }
        }
    }

    int operations = 0;
    double currentSum = sum;

    while (currentSum > target) {
        double largest = heap[1];
        heap[1] = heap[heapSize--];

        int j = 1;
        while (2 * j <= heapSize) {
            int k = 2 * j;
            if (k + 1 <= heapSize && heap[k + 1] > heap[k]) {
                k++;
            }
            if (heap[j] < heap[k]) {
                double temp = heap[j];
                heap[j] = heap[k];
                heap[k] = temp;
                j = k;
            } else {
                break;
            }
        }

        currentSum -= largest / 2.0;
        heap[++heapSize] = largest / 2.0;

        j = heapSize;
        while (j > 1 && heap[j] > heap[j / 2]) {
            double temp = heap[j];
            heap[j] = heap[j / 2];
            heap[j / 2] = temp;
            j /= 2;
        }

        operations++;
    }

    free(heap);
    return operations;
}