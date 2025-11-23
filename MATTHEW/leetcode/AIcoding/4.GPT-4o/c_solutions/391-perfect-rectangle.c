#include <stdbool.h>
#include <stdlib.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    int x1, y1, x2, y2;
} Rectangle;

bool isRectangleCover(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    int x1 = INT_MAX, y1 = INT_MAX, x2 = INT_MIN, y2 = INT_MIN;
    int area = 0;
    int count[128] = {0};

    for (int i = 0; i < rectanglesSize; i++) {
        int x1_rec = rectangles[i][0], y1_rec = rectangles[i][1];
        int x2_rec = rectangles[i][2], y2_rec = rectangles[i][3];

        x1 = x1_rec < x1 ? x1_rec : x1;
        y1 = y1_rec < y1 ? y1_rec : y1;
        x2 = x2_rec > x2 ? x2_rec : x2;
        y2 = y2_rec > y2 ? y2_rec : y2;

        area += (x2_rec - x1_rec) * (y2_rec - y1_rec);

        count[(x1_rec << 16) + y1_rec]++;
        count[(x2_rec << 16) + y1_rec]++;
        count[(x1_rec << 16) + y2_rec]++;
        count[(x2_rec << 16) + y2_rec]++;
    }

    if (area != (x2 - x1) * (y2 - y1)) return false;

    int cornerCount = 0;
    for (int i = 0; i < 128; i++) {
        if (count[i] == 1 || count[i] == 3) cornerCount++;
        else if (count[i] == 2) continue;
        else return false;
    }

    return cornerCount == 4;
}