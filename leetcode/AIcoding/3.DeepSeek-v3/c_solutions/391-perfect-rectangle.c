#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point bottom_left;
    Point top_right;
} Rectangle;

int cmp(const void* a, const void* b) {
    Point* p1 = (Point*)a;
    Point* p2 = (Point*)b;
    if (p1->x != p2->x) return p1->x - p2->x;
    return p1->y - p2->y;
}

bool isRectangleCover(int** rectangles, int rectanglesSize, int* rectanglesColSize) {
    if (rectanglesSize == 0) return false;

    long total_area = 0;
    int min_x = INT_MAX, min_y = INT_MAX, max_x = INT_MIN, max_y = INT_MIN;

    Point* corners = malloc(rectanglesSize * 4 * sizeof(Point));
    int corner_count = 0;

    for (int i = 0; i < rectanglesSize; i++) {
        int x1 = rectangles[i][0];
        int y1 = rectangles[i][1];
        int x2 = rectangles[i][2];
        int y2 = rectangles[i][3];

        total_area += (long)(x2 - x1) * (long)(y2 - y1);

        min_x = (x1 < min_x) ? x1 : min_x;
        min_y = (y1 < min_y) ? y1 : min_y;
        max_x = (x2 > max_x) ? x2 : max_x;
        max_y = (y2 > max_y) ? y2 : max_y;

        corners[corner_count++] = (Point){x1, y1};
        corners[corner_count++] = (Point){x1, y2};
        corners[corner_count++] = (Point){x2, y1};
        corners[corner_count++] = (Point){x2, y2};
    }

    long expected_area = (long)(max_x - min_x) * (long)(max_y - min_y);
    if (total_area != expected_area) {
        free(corners);
        return false;
    }

    qsort(corners, corner_count, sizeof(Point), cmp);

    Point expected_corners[4] = {
        {min_x, min_y},
        {min_x, max_y},
        {max_x, min_y},
        {max_x, max_y}
    };

    int expected_count = 0;
    for (int i = 0; i < corner_count; i++) {
        if (i > 0 && corners[i].x == corners[i-1].x && corners[i].y == corners[i-1].y) {
            continue;
        }
        if (i < corner_count - 1 && corners[i].x == corners[i+1].x && corners[i].y == corners[i+1].y) {
            i++;
            continue;
        }

        bool found = false;
        for (int j = 0; j < 4; j++) {
            if (corners[i].x == expected_corners[j].x && corners[i].y == expected_corners[j].y) {
                expected_count++;
                found = true;
                break;
            }
        }

        if (!found) {
            free(corners);
            return false;
        }
    }

    free(corners);
    return expected_count == 4;
}