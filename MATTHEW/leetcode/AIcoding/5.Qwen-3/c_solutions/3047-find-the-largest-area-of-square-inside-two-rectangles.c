#include <stdio.h>
#include <stdlib.h>

int largestSquareArea(int** topleft, int topleftSize, int* topleftColSize, int** bottomright, int bottomrightSize, int* bottomrightColSize) {
    int x1 = topleft[0][0], y1 = topleft[0][1];
    int x2 = bottomright[0][0], y2 = bottomright[0][1];
    int x3 = topleft[1][0], y3 = topleft[1][1];
    int x4 = bottomright[1][0], y4 = bottomright[1][1];

    int overlap_x_start = (x1 > x3) ? x1 : x3;
    int overlap_y_start = (y1 > y3) ? y1 : y3;
    int overlap_x_end = (x2 < x4) ? x2 : x4;
    int overlap_y_end = (y2 < y4) ? y2 : y4;

    if (overlap_x_start >= overlap_x_end || overlap_y_start >= overlap_y_end) {
        return 0;
    }

    int width = overlap_x_end - overlap_x_start;
    int height = overlap_y_end - overlap_y_start;
    return (width < height) ? width * width : height * height;
}