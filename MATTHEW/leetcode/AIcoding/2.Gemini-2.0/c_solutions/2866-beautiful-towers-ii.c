#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long beautifulTowers(int* maxHeights, int maxHeightsSize) {
    long long result = 0;
    for (int i = 0; i < maxHeightsSize; i++) {
        long long currentSum = 0;
        int currentHeight = maxHeights[i];
        currentSum += currentHeight;
        int leftHeight = currentHeight;
        for (int j = i - 1; j >= 0; j--) {
            if (maxHeights[j] <= leftHeight) {
                leftHeight = maxHeights[j];
            } else {
                leftHeight = leftHeight;
            }
            currentSum += leftHeight;
        }
        int rightHeight = currentHeight;
        for (int j = i + 1; j < maxHeightsSize; j++) {
            if (maxHeights[j] <= rightHeight) {
                rightHeight = maxHeights[j];
            } else {
                rightHeight = rightHeight;
            }
            currentSum += rightHeight;
        }
        if (i == 0 || currentSum < result) {
            result = currentSum;
        }
    }
    return result;
}