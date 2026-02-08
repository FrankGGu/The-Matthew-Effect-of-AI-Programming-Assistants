#include <stdio.h>
#include <stdlib.h>
#include <string.h>

typedef struct {
    int x;
    int y;
} Point;

double dist(Point p1, Point p2) {
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
}

double cross_product(Point a, Point b, Point c) {
    return (b.x - a.x) * (c.y - a.y) - (b.y - a.y) * (c.x - a.x);
}

double minAreaFreeRect(int** points, int pointsSize, int* pointsColSize) {
    double minArea = 1e9;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            for (int k = j + 1; k < pointsSize; k++) {
                Point p1 = {points[i][0], points[i][1]};
                Point p2 = {points[j][0], points[j][1]};
                Point p3 = {points[k][0], points[k][1]};

                Point p4;
                double cp = cross_product(p1, p2, p3);

                if (fabs(cp) < 1e-9) continue;

                p4.x = p2.x + p3.x - p1.x;
                p4.y = p2.y + p3.y - p1.y;

                int found = 0;
                for (int l = 0; l < pointsSize; l++) {
                    if (l != i && l != j && l != k) {
                        Point p = {points[l][0], points[l][1]};
                        if (p.x == p4.x && p.y == p4.y) {
                            found = 1;
                            break;
                        }
                    }
                }

                if (found) {
                    double area = dist(p1, p2) * dist(p2, p3);
                    minArea = fmin(minArea, area);
                }
            }
        }
    }

    if (minArea >= 1e9) return 0.0;

    double res = 1e9;
    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            for (int k = j + 1; k < pointsSize; k++) {
                for (int l = k + 1; l < pointsSize; l++) {
                    Point p1 = {points[i][0], points[i][1]};
                    Point p2 = {points[j][0], points[j][1]};
                    Point p3 = {points[k][0], points[k][1]};
                    Point p4 = {points[l][0], points[l][1]};

                    double d12 = dist(p1, p2);
                    double d13 = dist(p1, p3);
                    double d14 = dist(p1, p4);
                    double d23 = dist(p2, p3);
                    double d24 = dist(p2, p4);
                    double d34 = dist(p3, p4);

                    if (fabs(d12 * d34 - d13 * d24) < 1e-6 && fabs(d12 * d34 - d14 * d23) < 1e-6) {
                        double cross = cross_product(p1, p2, p3);
                        if (fabs(cross) > 1e-6) {
                            double area = d12 * d34 * fabs(cross) / (d12 * d34);
                            res = fmin(res, area);
                        }
                    }

                    if (fabs(d13 * d24 - d12 * d34) < 1e-6 && fabs(d13 * d24 - d14 * d23) < 1e-6) {
                        double cross = cross_product(p1, p3, p2);
                        if (fabs(cross) > 1e-6) {
                            double area = d13 * d24 * fabs(cross) / (d13 * d24);
                            res = fmin(res, area);
                        }
                    }

                    if (fabs(d14 * d23 - d12 * d34) < 1e-6 && fabs(d14 * d23 - d13 * d24) < 1e-6) {
                        double cross = cross_product(p1, p4, p2);
                        if (fabs(cross) > 1e-6) {
                            double area = d14 * d23 * fabs(cross) / (d14 * d23);
                            res = fmin(res, area);
                        }
                    }
                }
            }
        }
    }

    if (res >= 1e9) return 0.0;
    return res;
}