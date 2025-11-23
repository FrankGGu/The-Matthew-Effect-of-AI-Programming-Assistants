#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int computeArea(int ax1, int ay1, int ax2, int ay2, int bx1, int by1, int bx2, int by2) {
    int areaA = (ax2 - ax1) * (ay2 - ay1);
    int areaB = (bx2 - bx1) * (by2 - by1);

    int overlapWidth = fmax(0, fmin(ax2, bx2) - fmax(ax1, bx1));
    int overlapHeight = fmax(0, fmin(ay2, by2) - fmax(ay1, by1));

    int overlapArea = overlapWidth * overlapHeight;

    return areaA + areaB - overlapArea;
}