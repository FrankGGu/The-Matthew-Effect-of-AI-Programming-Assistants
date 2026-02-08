#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long maximumSumOfHeights(int* maxHeights, int maxHeightsSize) {
    long long maxSum = 0;
    for (int i = 0; i < maxHeightsSize; i++) {
        long long currentSum = 0;
        int currentHeight = maxHeights[i];
        currentSum += currentHeight;
        for (int j = i - 1; j >= 0; j--) {
            if (maxHeights[j] <= currentHeight) {
                currentHeight = maxHeights[j];
            }
            currentSum += currentHeight;
        }
        currentHeight = maxHeights[i];
        for (int j = i + 1; j < maxHeightsSize; j++) {
            if (maxHeights[j] <= currentHeight) {
                currentHeight = maxHeights[j];
            }
            currentSum += currentHeight;
        }
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }
    return maxSum;
}