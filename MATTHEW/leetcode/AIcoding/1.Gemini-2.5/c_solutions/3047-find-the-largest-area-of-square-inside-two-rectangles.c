#include <stdio.h>
#include <stdlib.h>

static inline int int_max(int a, int b) {
    return a > b ? a : b;
}

static inline int int_min(int a, int b) {
    return a < b ? a : b;
}

long long largestSquareArea(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int r1_x1 = rectangles[0][0];
    int r1_y1 = rectangles[0][1];
    int r1_x2 = rectangles[0][2];
    int r1_y2 = rectangles[0][3];

    int r2_x1 = rectangles[1][0];
    int r2_y1 = rectangles[1][1];
    int r2_x2 = rectangles[1][2];
    int r2_y2 = rectangles[1][3];

    int intersect_x1 = int_max(r1_x1, r2_x1);
    int intersect_y1 = int_max(r1_y1, r2_y1);
    int intersect_x2 = int_min(r1_x2, r2_x2);
    int intersect_y2 = int_min(r1_y2, r2_y2);

    if (intersect_x1 >= intersect_x2 || intersect_y1 >= intersect_y2) {
        return 0;
    }

    int intersection_width = intersect_x2 - intersect_x1;
    int intersection_height = intersect_y2 - intersect_y1;

    int side_length = int_min(intersection_width, intersection_height);

    return (long long)side_length * side_length;
}