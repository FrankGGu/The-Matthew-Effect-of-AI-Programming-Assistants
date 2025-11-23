#include <stdlib.h>

long long min(long long a, long long b) {
    return (a < b) ? a : b;
}

long long maximumSumOfHeights(int* maxHeights, int maxHeightsSize) {
    long long maxSum = 0;
    int n = maxHeightsSize;

    for (int i = 0; i < n; i++) { // Iterate through all possible peak indices
        long long currentSum = 0;

        // Calculate sum for the left part (including the peak)
        long long prevHeightLeft = maxHeights[i];
        currentSum += prevHeightLeft;
        for (int j = i - 1; j >= 0; j--) {
            prevHeightLeft = min(maxHeights[j], prevHeightLeft);
            currentSum += prevHeightLeft;
        }

        // Calculate sum for the right part (excluding the peak, as it's already counted)
        long long prevHeightRight = maxHeights[i];
        for (int j = i + 1; j < n; j++) {
            prevHeightRight = min(maxHeights[j], prevHeightRight);
            currentSum += prevHeightRight;
        }

        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
}