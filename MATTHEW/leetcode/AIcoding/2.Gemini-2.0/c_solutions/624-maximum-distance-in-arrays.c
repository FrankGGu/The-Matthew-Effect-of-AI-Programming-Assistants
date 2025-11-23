#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int maxDistance(int** arrays, int arraysSize, int* arraysColSize){
    int minVal = INT_MAX, maxVal = INT_MIN;
    int secondMinVal = INT_MAX, secondMaxVal = INT_MIN;
    int minIndex = -1, maxIndex = -1;

    for (int i = 0; i < arraysSize; i++) {
        if (arrays[i][0] < minVal) {
            secondMinVal = minVal;
            minVal = arrays[i][0];
            minIndex = i;
        } else if (arrays[i][0] < secondMinVal) {
            secondMinVal = arrays[i][0];
        }

        if (arrays[i][arraysColSize[i] - 1] > maxVal) {
            secondMaxVal = maxVal;
            maxVal = arrays[i][arraysColSize[i] - 1];
            maxIndex = i;
        } else if (arrays[i][arraysColSize[i] - 1] > secondMaxVal) {
            secondMaxVal = arrays[i][arraysColSize[i] - 1];
        }
    }

    if (minIndex != maxIndex) {
        return maxVal - minVal;
    } else {
        return (secondMaxVal - minVal) > (maxVal - secondMinVal) ? (secondMaxVal - minVal) : (maxVal - secondMinVal);
    }
}