#include <stdio.h>
#include <stdlib.h>

int lastStoneWeight(int* stones, int stonesSize) {
    if (stonesSize == 0) return 0;
    if (stonesSize == 1) return stones[0];

    int* maxHeap = (int*)malloc(stonesSize * sizeof(int));
    for (int i = 0; i < stonesSize; i++) {
        maxHeap[i] = stones[i];
    }

    for (int i = (stonesSize - 1) / 2; i >= 0; i--) {
        int parent = i;
        while (parent * 2 + 1 < stonesSize) {
            int left = parent * 2 + 1;
            int right = parent * 2 + 2;
            int largest = parent;
            if (left < stonesSize && maxHeap[left] > maxHeap[largest]) {
                largest = left;
            }
            if (right < stonesSize && maxHeap[right] > maxHeap[largest]) {
                largest = right;
            }
            if (largest != parent) {
                int temp = maxHeap[parent];
                maxHeap[parent] = maxHeap[largest];
                maxHeap[largest] = temp;
                parent = largest;
            } else {
                break;
            }
        }
    }

    while (stonesSize > 1) {
        int max1 = maxHeap[0];
        maxHeap[0] = maxHeap[stonesSize - 1];
        stonesSize--;
        int parent = 0;
        while (parent * 2 + 1 < stonesSize) {
            int left = parent * 2 + 1;
            int right = parent * 2 + 2;
            int largest = parent;
            if (left < stonesSize && maxHeap[left] > maxHeap[largest]) {
                largest = left;
            }
            if (right < stonesSize && maxHeap[right] > maxHeap[largest]) {
                largest = right;
            }
            if (largest != parent) {
                int temp = maxHeap[parent];
                maxHeap[parent] = maxHeap[largest];
                maxHeap[largest] = temp;
                parent = largest;
            } else {
                break;
            }
        }

        int max2 = maxHeap[0];
        maxHeap[0] = maxHeap[stonesSize - 1];
        stonesSize--;
        parent = 0;
        while (parent * 2 + 1 < stonesSize) {
            int left = parent * 2 + 1;
            int right = parent * 2 + 2;
            int largest = parent;
            if (left < stonesSize && maxHeap[left] > maxHeap[largest]) {
                largest = left;
            }
            if (right < stonesSize && maxHeap[right] > maxHeap[largest]) {
                largest = right;
            }
            if (largest != parent) {
                int temp = maxHeap[parent];
                maxHeap[parent] = maxHeap[largest];
                maxHeap[largest] = temp;
                parent = largest;
            } else {
                break;
            }
        }

        if (max1 != max2) {
            int newStone = max1 - max2;
            maxHeap[stonesSize] = newStone;
            stonesSize++;
            parent = stonesSize / 2 - 1;
            while (parent >= 0) {
                int left = parent * 2 + 1;
                int right = parent * 2 + 2;
                int largest = parent;
                if (left < stonesSize && maxHeap[left] > maxHeap[largest]) {
                    largest = left;
                }
                if (right < stonesSize && maxHeap[right] > maxHeap[largest]) {
                    largest = right;
                }
                if (largest != parent) {
                    int temp = maxHeap[parent];
                    maxHeap[parent] = maxHeap[largest];
                    maxHeap[largest] = temp;
                    parent = largest;
                } else {
                    break;
                }
            }
        }
    }

    return stonesSize == 0 ? 0 : maxHeap[0];
}