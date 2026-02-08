#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxScore(int* cardPoints, int cardPointsSize, int k){
    int totalSum = 0;
    for (int i = 0; i < cardPointsSize; i++) {
        totalSum += cardPoints[i];
    }

    int windowSize = cardPointsSize - k;
    int currentSum = 0;
    for (int i = 0; i < windowSize; i++) {
        currentSum += cardPoints[i];
    }

    int minSum = currentSum;
    for (int i = windowSize; i < cardPointsSize; i++) {
        currentSum += cardPoints[i] - cardPoints[i - windowSize];
        minSum = (currentSum < minSum) ? currentSum : minSum;
    }

    return totalSum - minSum;
}