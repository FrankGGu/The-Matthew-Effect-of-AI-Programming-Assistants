#include <stdio.h>
#include <stdlib.h>

int kItemsWithMaximumSum(int* nums, int numsSize, int k, int* queries, int queriesSize) {
    int* heap = (int*)malloc(k * sizeof(int));
    int size = 0;

    for (int i = 0; i < numsSize; i++) {
        if (size < k) {
            heap[size++] = nums[i];
            if (size > 1) {
                int child = size - 1;
                while (child > 0) {
                    int parent = (child - 1) / 2;
                    if (heap[parent] > heap[child]) {
                        int temp = heap[parent];
                        heap[parent] = heap[child];
                        heap[child] = temp;
                        child = parent;
                    } else {
                        break;
                    }
                }
            }
        } else {
            if (nums[i] < heap[0]) {
                heap[0] = nums[i];
                int parent = 0;
                int child = 1;
                while (child < size) {
                    if (child + 1 < size && heap[child + 1] < heap[child]) {
                        child++;
                    }
                    if (heap[parent] > heap[child]) {
                        int temp = heap[parent];
                        heap[parent] = heap[child];
                        heap[child] = temp;
                        parent = child;
                        child = 2 * parent + 1;
                    } else {
                        break;
                    }
                }
            }
        }
    }

    int sum = 0;
    for (int i = 0; i < k; i++) {
        sum += heap[i];
    }

    free(heap);
    return sum;
}