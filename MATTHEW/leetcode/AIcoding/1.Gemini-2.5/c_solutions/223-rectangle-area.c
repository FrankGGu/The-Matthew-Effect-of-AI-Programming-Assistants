#include <stdlib.h> // Required for max/min if not implementing manually

static int max(int a, int b) {
    return a > b ? a : b;
}

static int min(int a, int b) {
    return a < b ? a : b;
}

int computeArea(int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    // Calculate the area of the first rectangle
    int area1 = (ax2 - ax1) * (ay2 - ay1);

    // Calculate the area of the second rectangle
    int area2 = (bx2 - bx1) * (by2 - by1);

    // Calculate the coordinates of the overlapping rectangle
    int overlap_x1 = max(ax1, bx1);
    int overlap_y1 = max(ay1, by1);
    int overlap_x2 = min(ax2, bx2);
    int overlap_y2 = min(ay2, by2);

    // Calculate the width and height of the overlapping rectangle
    // If there is no overlap, width or height will be non-positive,
    // so max(0, ...) ensures it's 0.
    int overlap_width = max(0, overlap_x2 - overlap_x1);
    int overlap_height = max(0, overlap_y2 - overlap_y1);

    // Calculate the area of the overlapping rectangle
    int overlap_area = overlap_width * overlap_height;

    // The total area is the sum of individual areas minus the overlap area
    return area1 + area2 - overlap_area;
}