#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int largestSquareArea(int bottomLeft1[], int topRight1[], int bottomLeft2[], int topRight2[]) {
    int x_overlap_left = fmax(bottomLeft1[0], bottomLeft2[0]);
    int y_overlap_bottom = fmax(bottomLeft1[1], bottomLeft2[1]);
    int x_overlap_right = fmin(topRight1[0], topRight2[0]);
    int y_overlap_top = fmin(topRight1[1], topRight2[1]);

    if (x_overlap_left >= x_overlap_right || y_overlap_bottom >= y_overlap_top) {
        return 0;
    }

    int side = fmin(x_overlap_right - x_overlap_left, y_overlap_top - y_overlap_bottom);
    return side * side;
}