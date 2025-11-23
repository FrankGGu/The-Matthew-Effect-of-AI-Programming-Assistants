#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int removeStones(int* piles, int pilesSize, int k) {
    int sum = 0;
    int maxPile = 0;
    for (int i = 0; i < pilesSize; i++) {
        sum += piles[i];
        if (piles[i] > maxPile) {
            maxPile = piles[i];
        }
    }

    int* heap = (int*)malloc(sizeof(int) * (pilesSize + 1));
    int heapSize = 0;

    for (int i = 0; i < pilesSize; i++) {
        heap[++heapSize] = piles[i];
    }

    for (int i = heapSize / 2; i >= 1; i--) {
        int j = i;
        while (2 * j <= heapSize) {
            int child = 2 * j;
            if (child < heapSize && heap[child + 1] > heap[child]) {
                child++;
            }
            if (heap[j] < heap[child]) {
                int temp = heap[j];
                heap[j] = heap[child];
                heap[child] = temp;
                j = child;
            } else {
                break;
            }
        }
    }

    for (int i = 0; i < k; i++) {
        int largest = heap[1];
        heap[1] = heap[heapSize--];

        int j = 1;
        while (2 * j <= heapSize) {
            int child = 2 * j;
            if (child < heapSize && heap[child + 1] > heap[child]) {
                child++;
            }
            if (heap[j] < heap[child]) {
                int temp = heap[j];
                heap[j] = heap[child];
                heap[child] = temp;
                j = child;
            } else {
                break;
            }
        }

        sum -= largest / 2;
        heap[++heapSize] = largest - largest / 2;

        j = heapSize;
        while (j > 1 && heap[j] > heap[j / 2]) {
            int temp = heap[j];
            heap[j] = heap[j / 2];
            heap[j / 2] = temp;
            j /= 2;
        }
    }

    free(heap);
    return sum;
}