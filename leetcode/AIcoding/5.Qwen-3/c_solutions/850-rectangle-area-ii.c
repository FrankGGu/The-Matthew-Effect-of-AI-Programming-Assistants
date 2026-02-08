#include <stdio.h>
#include <stdlib.h>

typedef struct {
    int x1;
    int y1;
    int x2;
    int y2;
} Rectangle;

int cmp(const void *a, const void *b) {
    return ((Rectangle *)a)->x1 - ((Rectangle *)b)->x1;
}

int getArea(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    Rectangle *rects = (Rectangle *)malloc(rectanglesSize * sizeof(Rectangle));
    for (int i = 0; i < rectanglesSize; i++) {
        rects[i].x1 = rectangles[i][0];
        rects[i].y1 = rectangles[i][1];
        rects[i].x2 = rectangles[i][2];
        rects[i].y2 = rectangles[i][3];
    }

    qsort(rects, rectanglesSize, sizeof(Rectangle), cmp);

    int area = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        int x1 = rects[i].x1;
        int y1 = rects[i].y1;
        int x2 = rects[i].x2;
        int y2 = rects[i].y2;

        for (int j = i + 1; j < rectanglesSize; j++) {
            if (rects[j].x1 >= x2) break;
            if (rects[j].x2 <= x1) continue;
            if (rects[j].y1 >= y2) continue;
            if (rects[j].y2 <= y1) continue;

            int overlapX1 = (x1 > rects[j].x1) ? x1 : rects[j].x1;
            int overlapY1 = (y1 > rects[j].y1) ? y1 : rects[j].y1;
            int overlapX2 = (x2 < rects[j].x2) ? x2 : rects[j].x2;
            int overlapY2 = (y2 < rects[j].y2) ? y2 : rects[j].y2;

            area += (overlapX2 - overlapX1) * (overlapY2 - overlapY1);
        }
    }

    free(rects);
    return area;
}