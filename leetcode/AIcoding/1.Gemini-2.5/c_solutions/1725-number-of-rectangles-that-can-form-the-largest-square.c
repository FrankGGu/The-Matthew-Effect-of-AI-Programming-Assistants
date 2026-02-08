#include <stdlib.h> // Required for NULL, if not explicitly used, can be omitted.
#include <stdio.h>  // Required for NULL, if not explicitly used, can be omitted.

int countGoodRectangles(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int max_side = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        int current_side = (rectangles[i][0] < rectangles[i][1]) ? rectangles[i][0] : rectangles[i][1];
        if (current_side > max_side) {
            max_side = current_side;
        }
    }

    int count = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        int current_side = (rectangles[i][0] < rectangles[i][1]) ? rectangles[i][0] : rectangles[i][1];
        if (current_side == max_side) {
            count++;
        }
    }

    return count;
}