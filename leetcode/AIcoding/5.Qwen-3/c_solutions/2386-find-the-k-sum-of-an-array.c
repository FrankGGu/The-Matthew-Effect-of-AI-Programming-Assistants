#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long kSum(int* nums, int numsSize, int k) {
    long long sum = 0;
    for (int i = 0; i < numsSize; i++) {
        sum += nums[i];
    }

    int* abs_nums = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        abs_nums[i] = abs(nums[i]);
    }

    qsort(abs_nums, numsSize, sizeof(int), compare);

    long long* heap = (long long*)malloc(k * sizeof(long long));
    heap[0] = sum;
    int heap_size = 1;

    for (int i = 0; i < numsSize; i++) {
        long long new_heap[heap_size + 1];
        int new_heap_size = 0;

        for (int j = 0; j < heap_size; j++) {
            new_heap[new_heap_size++] = heap[j];
            new_heap[new_heap_size++] = heap[j] - 2 * abs_nums[i];
        }

        qsort(new_heap, new_heap_size, sizeof(long long), compare);

        heap_size = 0;
        for (int j = 0; j < new_heap_size && heap_size < k; j++) {
            if (heap_size == 0 || new_heap[j] != heap[heap_size - 1]) {
                heap[heap_size++] = new_heap[j];
            }
        }
    }

    long long result = heap[k - 1];
    free(abs_nums);
    free(heap);
    return result;
}