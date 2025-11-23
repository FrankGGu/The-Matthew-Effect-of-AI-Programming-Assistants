#include <stdio.h>
#include <stdlib.h>

long long maximizeSumOfWeights(int n, int* weights, int weightsSize, int** edges, int edgesSize, int* edgesColSize) {
    long long totalSum = 0;
    for (int i = 0; i < n; i++) {
        totalSum += weights[i];
    }
    return totalSum;
}