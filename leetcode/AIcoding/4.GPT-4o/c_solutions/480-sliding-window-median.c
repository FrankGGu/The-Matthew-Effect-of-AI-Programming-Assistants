#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int *data;
    int size;
} Heap;

void swap(int *a, int *b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify(Heap *heap, int idx) {
    int largest = idx;
    int left = 2 * idx + 1;
    int right = 2 * idx + 2;

    if (left < heap->size && heap->data[left] > heap->data[largest]) {
        largest = left;
    }
    if (right < heap->size && heap->data[right] > heap->data[largest]) {
        largest = right;
    }
    if (largest != idx) {
        swap(&heap->data[idx], &heap->data[largest]);
        heapify(heap, largest);
    }
}

void insertHeap(Heap *heap, int val) {
    heap->data[heap->size] = val;
    heap->size++;
    for (int i = (heap->size / 2) - 1; i >= 0; i--) {
        heapify(heap, i);
    }
}

int extractMax(Heap *heap) {
    if (heap->size == 0) return -1;
    int maxVal = heap->data[0];
    heap->data[0] = heap->data[heap->size - 1];
    heap->size--;
    heapify(heap, 0);
    return maxVal;
}

double getMedian(Heap *maxHeap, Heap *minHeap) {
    if (maxHeap->size > minHeap->size) {
        return maxHeap->data[0];
    } else if (maxHeap->size < minHeap->size) {
        return minHeap->data[0];
    }
    return (maxHeap->data[0] + minHeap->data[0]) / 2.0;
}

double* medianSlidingWindow(int* nums, int numsSize, int k, int* returnSize) {
    *returnSize = numsSize - k + 1;
    double *result = (double *)malloc((*returnSize) * sizeof(double));
    Heap maxHeap = { (int *)malloc(k * sizeof(int)), 0 };
    Heap minHeap = { (int *)malloc(k * sizeof(int)), 0 };

    for (int i = 0; i < numsSize; i++) {
        if (maxHeap.size == 0 || nums[i] <= maxHeap.data[0]) {
            insertHeap(&maxHeap, nums[i]);
        } else {
            insertHeap(&minHeap, nums[i]);
        }

        if (maxHeap.size > minHeap.size + 1) {
            insertHeap(&minHeap, extractMax(&maxHeap));
        } else if (minHeap.size > maxHeap.size) {
            insertHeap(&maxHeap, extractMax(&minHeap));
        }

        if (i >= k - 1) {
            result[i - k + 1] = getMedian(&maxHeap, &minHeap);
            int toRemove = nums[i - k + 1];
            if (toRemove <= maxHeap.data[0]) {
                for (int j = 0; j < maxHeap.size; j++) {
                    if (maxHeap.data[j] == toRemove) {
                        swap(&maxHeap.data[j], &maxHeap.data[maxHeap.size - 1]);
                        maxHeap.size--;
                        heapify(&maxHeap, j);
                        break;
                    }
                }
            } else {
                for (int j = 0; j < minHeap.size; j++) {
                    if (minHeap.data[j] == toRemove) {
                        swap(&minHeap.data[j], &minHeap.data[minHeap.size - 1]);
                        minHeap.size--;
                        heapify(&minHeap, j);
                        break;
                    }
                }
            }

            if (maxHeap.size > minHeap.size + 1) {
                insertHeap(&minHeap, extractMax(&maxHeap));
            } else if (minHeap.size > maxHeap.size) {
                insertHeap(&maxHeap, extractMax(&minHeap));
            }
        }
    }

    free(maxHeap.data);
    free(minHeap.data);
    return result;
}