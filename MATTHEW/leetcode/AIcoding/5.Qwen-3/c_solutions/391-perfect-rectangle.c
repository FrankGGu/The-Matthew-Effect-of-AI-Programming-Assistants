#include <stdio.h>
#include <stdlib.h>
#include <limits.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point left_top;
    Point right_bottom;
} Rectangle;

int cmp(const void *a, const void *b) {
    Rectangle *r1 = (Rectangle *)a;
    Rectangle *r2 = (Rectangle *)b;
    if (r1->left_top.x != r2->left_top.x) {
        return r1->left_top.x - r2->left_top.x;
    }
    return r1->left_top.y - r2->left_top.y;
}

int isPerfectRectangle(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    if (rectanglesSize == 0) return 0;
    if (rectanglesSize == 1) return 1;

    Rectangle *rects = (Rectangle *)malloc(rectanglesSize * sizeof(Rectangle));
    for (int i = 0; i < rectanglesSize; i++) {
        rects[i].left_top.x = rectangles[i][0];
        rects[i].left_top.y = rectangles[i][1];
        rects[i].right_bottom.x = rectangles[i][2];
        rects[i].right_bottom.y = rectangles[i][3];
    }

    qsort(rects, rectanglesSize, sizeof(Rectangle), cmp);

    int total_area = 0;
    int min_x = INT_MAX, min_y = INT_MAX, max_x = INT_MIN, max_y = INT_MIN;

    for (int i = 0; i < rectanglesSize; i++) {
        int area = (rects[i].right_bottom.x - rects[i].left_top.x) * (rects[i].right_bottom.y - rects[i].left_top.y);
        total_area += area;

        min_x = (rects[i].left_top.x < min_x) ? rects[i].left_top.x : min_x;
        min_y = (rects[i].left_top.y < min_y) ? rects[i].left_top.y : min_y;
        max_x = (rects[i].right_bottom.x > max_x) ? rects[i].right_bottom.x : max_x;
        max_y = (rects[i].right_bottom.y > max_y) ? rects[i].right_bottom.y : max_y;
    }

    int expected_area = (max_x - min_x) * (max_y - min_y);
    if (total_area != expected_area) {
        free(rects);
        return 0;
    }

    int count = 0;
    for (int i = 0; i < rectanglesSize; i++) {
        if (rects[i].left_top.x == min_x && rects[i].left_top.y == min_y) count++;
        if (rects[i].right_bottom.x == max_x && rects[i].right_bottom.y == max_y) count++;
    }

    if (count != 2) {
        free(rects);
        return 0;
    }

    for (int i = 0; i < rectanglesSize; i++) {
        for (int j = i + 1; j < rectanglesSize; j++) {
            int x_overlap = (rects[i].left_top.x < rects[j].right_bottom.x) && (rects[i].right_bottom.x > rects[j].left_top.x);
            int y_overlap = (rects[i].left_top.y < rects[j].right_bottom.y) && (rects[i].right_bottom.y > rects[j].left_top.y);
            if (x_overlap && y_overlap) {
                free(rects);
                return 0;
            }
        }
    }

    free(rects);
    return 1;
}