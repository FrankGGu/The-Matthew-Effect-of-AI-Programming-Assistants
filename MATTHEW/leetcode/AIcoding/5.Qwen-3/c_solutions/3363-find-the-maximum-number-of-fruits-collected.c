#include <stdio.h>
#include <stdlib.h>

int maxTotalFruits(int** fruitPositions, int* fruitPositionsSize, int** fruitCounts, int* fruitCountsSize, int k) {
    int n = *fruitPositionsSize;
    int* positions = *fruitPositions;
    int* counts = *fruitCounts;

    int maxFruits = 0;
    int left = 0;

    for (int right = 0; right < n; right++) {
        while (positions[right] - positions[left] > k) {
            left++;
        }

        int total = 0;
        for (int i = left; i <= right; i++) {
            total += counts[i];
        }

        if (total > maxFruits) {
            maxFruits = total;
        }
    }

    return maxFruits;
}