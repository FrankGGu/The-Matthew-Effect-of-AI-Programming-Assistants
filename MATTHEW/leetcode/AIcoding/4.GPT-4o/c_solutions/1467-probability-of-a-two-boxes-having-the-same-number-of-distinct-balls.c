#include <stdio.h>
#include <stdlib.h>

double getProbability(int* box1, int box1Size, int* box2, int box2Size) {
    int totalBalls = 0;
    for (int i = 0; i < box1Size; i++) totalBalls += box1[i];
    for (int i = 0; i < box2Size; i++) totalBalls += box2[i];

    double totalWays = 1;
    for (int i = 1; i <= totalBalls; i++) {
        totalWays *= i;
    }

    double validWays = 1;
    for (int i = 0; i < box1Size; i++) {
        for (int j = 0; j < box1[i]; j++) {
            validWays *= (totalBalls - j);
        }
        for (int j = 1; j <= box1[i]; j++) {
            validWays /= j;
        }
    }

    for (int i = 0; i < box2Size; i++) {
        for (int j = 0; j < box2[i]; j++) {
            validWays *= (totalBalls - box1[i] - j);
        }
        for (int j = 1; j <= box2[i]; j++) {
            validWays /= j;
        }
    }

    return validWays / totalWays;
}