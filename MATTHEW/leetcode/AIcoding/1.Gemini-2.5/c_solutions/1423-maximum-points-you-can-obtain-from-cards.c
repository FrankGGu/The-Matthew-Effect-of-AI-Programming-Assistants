#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScore(int* cardPoints, int cardPointsSize, int k) {
    int currentSum = 0;
    for (int i = 0; i < k; i++) {
        currentSum += cardPoints[i];
    }

    int maxSum = currentSum;

    for (int i = 0; i < k; i++) {
        currentSum = currentSum - cardPoints[k - 1 - i] + cardPoints[cardPointsSize - 1 - i];
        if (currentSum > maxSum) {
            maxSum = currentSum;
        }
    }

    return maxSum;
}