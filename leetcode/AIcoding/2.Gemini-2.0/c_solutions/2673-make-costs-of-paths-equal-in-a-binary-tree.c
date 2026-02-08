#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int minIncrements(int n, int* cost, int costSize) {
    int increments = 0;
    for (int i = n / 2 - 1; i >= 0; i--) {
        int leftChildIndex = 2 * i + 1;
        int rightChildIndex = 2 * i + 2;

        increments += abs(cost[leftChildIndex] - cost[rightChildIndex]);
        cost[i] += (cost[leftChildIndex] > cost[rightChildIndex]) ? cost[leftChildIndex] : cost[rightChildIndex];
    }
    return increments;
}