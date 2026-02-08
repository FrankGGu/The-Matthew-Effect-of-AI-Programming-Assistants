#include <stdio.h>
#include <stdlib.h>
#include <string.h>

double getMinDistSum(int** positions, int positionsSize, int* positionsColSize) {
    double x = 0.0;
    double y = 0.0;
    for (int i = 0; i < positionsSize; i++) {
        x += positions[i][0];
        y += positions[i][1];
    }
    x /= positionsSize;
    y /= positionsSize;

    double learningRate = 0.1;
    double minLearningRate = 1e-6;
    double decayFactor = 0.95;

    while (learningRate > minLearningRate) {
        double dx = 0.0;
        double dy = 0.0;
        double wSum = 0.0;

        for (int i = 0; i < positionsSize; i++) {
            double dist = sqrt(pow(x - positions[i][0], 2) + pow(y - positions[i][1], 2));
            if (dist > 1e-9) {
                double w = 1.0 / dist;
                dx += (positions[i][0] - x) * w;
                dy += (positions[i][1] - y) * w;
                wSum += w;
            }
        }

        x += learningRate * dx / wSum;
        y += learningRate * dy / wSum;
        learningRate *= decayFactor;
    }

    double totalDist = 0.0;
    for (int i = 0; i < positionsSize; i++) {
        totalDist += sqrt(pow(x - positions[i][0], 2) + pow(y - positions[i][1], 2));
    }

    return totalDist;
}