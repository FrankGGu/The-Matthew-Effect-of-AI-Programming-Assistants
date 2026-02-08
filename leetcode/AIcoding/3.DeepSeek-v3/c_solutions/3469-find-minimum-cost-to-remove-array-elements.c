#include <stdlib.h>
#include <limits.h>

int compare(const void* a, const void* b) {
    return (*(int*)b - *(int*)a);
}

int minCost(int* nums, int numsSize) {
    int* heap = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        heap[i] = nums[i];
    }
    qsort(heap, numsSize, sizeof(int), compare);

    int cost = 0;
    int heapSize = numsSize;

    while (heapSize > 1) {
        int first = heap[0];
        int second = heap[1];

        cost += first + second;

        heap[0] = first + second;
        heap[1] = heap[heapSize - 1];
        heapSize--;

        int idx = 0;
        while (1) {
            int left = 2 * idx + 1;
            int right = 2 * idx + 2;
            int largest = idx;

            if (left < heapSize && heap[left] > heap[largest]) {
                largest = left;
            }
            if (right < heapSize && heap[right] > heap[largest]) {
                largest = right;
            }
            if (largest == idx) break;

            int temp = heap[idx];
            heap[idx] = heap[largest];
            heap[largest] = temp;
            idx = largest;
        }
    }

    free(heap);
    return cost;
}