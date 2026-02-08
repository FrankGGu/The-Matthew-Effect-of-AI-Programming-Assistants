#include <stdio.h>
#include <stdlib.h>

long long manhattanDistance(int *arr, int size) {
    long long distance = 0;
    for (int i = 0; i < size; i++) {
        distance += abs(arr[i] - (i + 1));
    }
    return distance;
}

long long sumOfDistances(int **pieces, int piecesSize, int *piecesColSize) {
    long long totalDistance = 0;
    for (int i = 0; i < piecesSize; i++) {
        totalDistance += manhattanDistance(pieces[i], piecesColSize[i]);
    }
    return totalDistance;
}

long long calculateManhattanDistances(int **pieces, int piecesSize, int *piecesColSize) {
    return sumOfDistances(pieces, piecesSize, piecesColSize);
}