#include <stdlib.h>
#include <stdio.h>

int cmp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long totalCost(int* costs, int costsSize, int k, int candidates) {
    long long total = 0;
    int left = 0, right = costsSize - 1;
    int count = 0;
    int *minHeap = (int*)malloc((k + 1) * sizeof(int));
    int heapSize = 0;

    while (count < k) {
        while (heapSize < k && (left <= right) && (left < candidates || right >= costsSize - candidates)) {
            if (left < candidates) {
                minHeap[heapSize++] = costs[left++];
            }
            if (right >= costsSize - candidates && right > left) {
                minHeap[heapSize++] = costs[right--];
            }
        }

        qsort(minHeap, heapSize, sizeof(int), cmp);
        total += minHeap[0];
        minHeap[0] = minHeap[--heapSize];
        count++;
    }

    free(minHeap);
    return total;
}