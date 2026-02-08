#include <stdio.h>
#include <stdlib.h>

int maxArea(int* dimensions, int dimensionsSize) {
    int maxArea = 0;
    for (int i = 0; i < dimensionsSize; i += 2) {
        int length = dimensions[i];
        int width = dimensions[i + 1];
        int area = length * width;
        if (area > maxArea) {
            maxArea = area;
        }
    }
    return maxArea;
}