#include <stdio.h>
#include <stdlib.h>

int minOperations(int* nums, int numsSize, int k) {
    int* heap = (int*)malloc(numsSize * sizeof(int));
    for (int i = 0; i < numsSize; i++) {
        heap[i] = nums[i];
    }

    for (int i = (numsSize - 1) / 2; i >= 0; i--) {
        int parent = i;
        while (parent * 2 + 1 < numsSize) {
            int left = parent * 2 + 1;
            int right = parent * 2 + 2;
            int smallest = left;
            if (right < numsSize && heap[right] < heap[left]) {
                smallest = right;
            }
            if (heap[smallest] < heap[parent]) {
                int temp = heap[smallest];
                heap[smallest] = heap[parent];
                heap[parent] = temp;
                parent = smallest;
            } else {
                break;
            }
        }
    }

    int operations = 0;
    while (1) {
        int sum = 0;
        int count = 0;
        for (int i = 0; i < numsSize; i++) {
            if (heap[i] < k) {
                sum += heap[i];
                count++;
            }
        }
        if (count <= 1) break;
        int min1 = heap[0];
        int min2 = heap[0];
        for (int i = 0; i < numsSize; i++) {
            if (heap[i] < k) {
                if (heap[i] < min1) {
                    min2 = min1;
                    min1 = heap[i];
                } else if (heap[i] < min2) {
                    min2 = heap[i];
                }
            }
        }
        int new_val = min1 + min2;
        operations++;
        heap[0] = new_val;
        int parent = 0;
        while (1) {
            int left = parent * 2 + 1;
            int right = parent * 2 + 2;
            int smallest = parent;
            if (left < numsSize && heap[left] < heap[smallest]) {
                smallest = left;
            }
            if (right < numsSize && heap[right] < heap[smallest]) {
                smallest = right;
            }
            if (smallest != parent) {
                int temp = heap[smallest];
                heap[smallest] = heap[parent];
                heap[parent] = temp;
                parent = smallest;
            } else {
                break;
            }
        }
    }

    free(heap);
    return operations;
}