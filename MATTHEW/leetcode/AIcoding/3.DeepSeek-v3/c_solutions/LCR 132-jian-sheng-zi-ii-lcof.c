#include <stdlib.h>
#include <string.h>

int cmp(const void* a, const void* b) {
    long long aa = *(long long*)a;
    long long bb = *(long long*)b;
    if (aa < bb) return 1;
    if (aa > bb) return -1;
    return 0;
}

int minOperations(int* nums, int numsSize, int k) {
    long long* heap = (long long*)malloc(numsSize * sizeof(long long));
    for (int i = 0; i < numsSize; i++) {
        heap[i] = nums[i];
    }

    qsort(heap, numsSize, sizeof(long long), cmp);

    int operations = 0;
    while (heap[0] >= k) {
        if (numsSize < 2) {
            free(heap);
            return -1;
        }

        long long x = heap[0];
        long long y = heap[1];

        long long new_val = x * 2 + y;

        heap[0] = new_val;
        heap[1] = heap[numsSize - 1];
        numsSize--;

        for (int i = (numsSize - 1) / 2; i >= 0; i--) {
            int parent = i;
            while (parent * 2 + 1 < numsSize) {
                int child = parent * 2 + 1;
                if (child + 1 < numsSize && heap[child + 1] > heap[child]) {
                    child++;
                }
                if (heap[child] > heap[parent]) {
                    long long temp = heap[parent];
                    heap[parent] = heap[child];
                    heap[child] = temp;
                    parent = child;
                } else {
                    break;
                }
            }
        }

        operations++;
    }

    free(heap);
    return operations;
}