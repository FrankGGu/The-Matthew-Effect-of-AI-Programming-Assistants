#include <stdlib.h>

void swap(int* a, int* b) {
    int temp = *a;
    *a = *b;
    *b = temp;
}

void heapify(int* heap, int size, int i) {
    int smallest = i;
    int left = 2 * i + 1;
    int right = 2 * i + 2;

    if (left < size && heap[left] < heap[smallest]) {
        smallest = left;
    }

    if (right < size && heap[right] < heap[smallest]) {
        smallest = right;
    }

    if (smallest != i) {
        swap(&heap[i], &heap[smallest]);
        heapify(heap, size, smallest);
    }
}

void buildHeap(int* heap, int size) {
    for (int i = size / 2 - 1; i >= 0; i--) {
        heapify(heap, size, i);
    }
}

int maximumProduct(int* nums, int numsSize, int k) {
    buildHeap(nums, numsSize);

    while (k > 0) {
        nums[0]++;
        heapify(nums, numsSize, 0);
        k--;
    }

    long long product = 1;
    int mod = 1000000007;

    for (int i = 0; i < numsSize; i++) {
        product = (product * nums[i]) % mod;
    }

    return (int)product;
}