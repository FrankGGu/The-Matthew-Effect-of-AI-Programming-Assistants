#include <stdio.h>
#include <stdlib.h>

int maxScore(int* cardPoints, int cardPointsSize, int k) {
    int total = 0;
    for (int i = 0; i < cardPointsSize; i++) {
        total += cardPoints[i];
    }

    int n = cardPointsSize;
    int windowSize = n - k;
    int current = 0;

    for (int i = 0; i < windowSize; i++) {
        current += cardPoints[i];
    }

    int minWindow = current;

    for (int i = windowSize; i < n; i++) {
        current += cardPoints[i] - cardPoints[i - windowSize];
        if (current < minWindow) {
            minWindow = current;
        }
    }

    return total - minWindow;
}