#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int compare(const void *a, const void *b) {
    return (*(int*)a - *(int*)b);
}

long long totalCost(int* costs, int costsSize, int k, int candidates) {
    long long total_cost = 0;
    int left = 0;
    int right = costsSize - 1;
    int hired = 0;

    int* left_heap = (int*)malloc(sizeof(int) * candidates);
    int* right_heap = (int*)malloc(sizeof(int) * candidates);
    int left_heap_size = 0;
    int right_heap_size = 0;

    while (hired < k) {
        while (left_heap_size < candidates && left <= right) {
            left_heap[left_heap_size++] = costs[left++];
        }
        while (right_heap_size < candidates && left <= right) {
            right_heap[right_heap_size++] = costs[right--];
        }

        qsort(left_heap, left_heap_size, sizeof(int), compare);
        qsort(right_heap, right_heap_size, sizeof(int), compare);

        if (left_heap_size == 0 && right_heap_size == 0) break;

        int left_min = (left_heap_size > 0) ? left_heap[0] : 2147483647;
        int right_min = (right_heap_size > 0) ? right_heap[0] : 2147483647;

        if (left_min <= right_min) {
            total_cost += left_min;

            left_heap[0] = 2147483647;
            qsort(left_heap, left_heap_size, sizeof(int), compare);
            left_heap_size--;

        } else {
            total_cost += right_min;

            right_heap[0] = 2147483647;
            qsort(right_heap, right_heap_size, sizeof(int), compare);
            right_heap_size--;
        }
        hired++;
    }
    free(left_heap);
    free(right_heap);
    return total_cost;
}