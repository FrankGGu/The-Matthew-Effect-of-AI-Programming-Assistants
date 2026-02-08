#include <stdio.h>
#include <stdlib.h>
#include <string.h>

struct Point {
    int x;
    int y;
};

int inside(int x, int y, int cx, int cy, int r) {
    return (x - cx) * (x - cx) + (y - cy) * (y - cy) <= r * r;
}

int maxPoints(struct Point* points, int pointsSize, int r) {
    int ans = 1;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            int x1 = points[i].x, y1 = points[i].y;
            int x2 = points[j].x, y2 = points[j].y;
            double d = sqrt((x1 - x2) * (x1 - x2) + (y1 - y2) * (y1 - y2));
            if (d > 2.0 * r) continue;
            double midX = (x1 + x2) / 2.0;
            double midY = (y1 + y2) / 2.0;
            double dist = sqrt(r * r - (d / 2.0) * (d / 2.0));
            double dx = (y1 - y2) * dist / (d);
            double dy = (x2 - x1) * dist / (d);
            double cx1 = midX + dx;
            double cy1 = midY + dy;
            double cx2 = midX - dx;
            double cy2 = midY - dy;

            int count1 = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (inside(points[k].x, points[k].y, (int)cx1, (int)cy1, r)) {
                    count1++;
                }
            }
            ans = (ans > count1) ? ans : count1;
            int count2 = 0;
            for (int k = 0; k < pointsSize; k++) {
                if (inside(points[k].x, points[k].y, (int)cx2, (int)cy2, r)) {
                    count2++;
                }
            }
            ans = (ans > count2) ? ans : count2;
        }
    }
    return ans;
}