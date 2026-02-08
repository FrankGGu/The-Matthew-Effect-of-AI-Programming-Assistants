#include <stdio.h>
#include <stdlib.h>
#include <string.h>

long long interchangeableRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize){
    int* gcds = (int*)malloc(sizeof(int) * rectanglesSize);
    double* ratios = (double*)malloc(sizeof(double) * rectanglesSize);
    long long count = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int width = rectangles[i][0];
        int height = rectangles[i][1];

        ratios[i] = (double)width / height;
    }

    for (int i = 0; i < rectanglesSize; i++) {
        for (int j = i + 1; j < rectanglesSize; j++) {
            if (ratios[i] == ratios[j]) {
                count++;
            }
        }
    }

    free(gcds);
    free(ratios);
    return count;
}