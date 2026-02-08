#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int comp(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long kSum(int* nums, int numsSize, int k) {
    long long sum = 0;
    int posSize = 0;
    int* posNums = (int*)malloc(numsSize * sizeof(int));

    for (int i = 0; i < numsSize; i++) {
        if (nums[i] >= 0) {
            sum += nums[i];
            posNums[posSize++] = nums[i];
        } else {
            posNums[posSize++] = -nums[i];
        }
    }

    qsort(posNums, posSize, sizeof(int), comp);

    long long* heap = (long long*)malloc(k * sizeof(long long));
    int* indices = (int*)malloc(k * sizeof(int));
    int heapSize = 0;

    heap[heapSize] = posNums[0];
    indices[heapSize] = 0;
    heapSize++;

    for (int i = 1; i < k; i++) {
        long long minVal = -1;
        int minIndex = -1;

        for (int j = 0; j < heapSize; j++) {
            int nextIndex = indices[j] + 1;
            if (nextIndex < posSize) {
                long long newVal = heap[j] + posNums[nextIndex];
                if (minVal == -1 || newVal < minVal) {
                    minVal = newVal;
                    minIndex = j;
                }
            }
        }

        if (minVal == -1) {
            break;
        }

        heap[i] = minVal;
        indices[i] = indices[minIndex] + 1;
        indices[minIndex] = posSize; 
        heapSize++;
    }

    long long result = sum;
    if (k > 1) {
        result -= heap[k - 1];
    } else {
         result -= posNums[0];
    }

    free(posNums);
    free(heap);
    free(indices);
    return result;
}