typedef struct {
    int x;
    int y;
} Point;

typedef struct {
    Point p1;
    Point p2;
    Point p3;
    Point p4;
} Rectangle;

double minAreaFreeRect(int** points, int pointsSize, int* pointsColSize) {
    Point *p = (Point *)malloc(pointsSize * sizeof(Point));
    for (int i = 0; i < pointsSize; i++) {
        p[i].x = points[i][0];
        p[i].y = points[i][1];
    }

    double min_area = -1.0;

    for (int i = 0; i < pointsSize; i++) {
        for (int j = i + 1; j < pointsSize; j++) {
            for (int k = j + 1; k < pointsSize; k++) {
                Point a = p[i], b = p[j], c = p[k];

                int abx = b.x - a.x, aby = b.y - a.y;
                int acx = c.x - a.x, acy = c.y - a.y;

                if (abx * acx + aby * acy == 0) {
                    Point d = {b.x + c.x - a.x, b.y + c.y - a.y};

                    for (int l = 0; l < pointsSize; l++) {
                        if (l == i || l == j || l == k) continue;
                        if (p[l].x == d.x && p[l].y == d.y) {
                            double area = sqrt(abx * abx + aby * aby) * sqrt(acx * acx + acy * acy);
                            if (min_area < 0 || area < min_area) {
                                min_area = area;
                            }
                        }
                    }
                }

                int bax = a.x - b.x, bay = a.y - b.y;
                int bcx = c.x - b.x, bcy = c.y - b.y;

                if (bax * bcx + bay * bcy == 0) {
                    Point d = {a.x + c.x - b.x, a.y + c.y - b.y};

                    for (int l = 0; l < pointsSize; l++) {
                        if (l == i || l == j || l == k) continue;
                        if (p[l].x == d.x && p[l].y == d.y) {
                            double area = sqrt(bax * bax + bay * bay) * sqrt(bcx * bcx + bcy * bcy);
                            if (min_area < 0 || area < min_area) {
                                min_area = area;
                            }
                        }
                    }
                }

                int cax = a.x - c.x, cay = a.y - c.y;
                int cbx = b.x - c.x, cby = b.y - c.y;

                if (cax * cbx + cay * cby == 0) {
                    Point d = {a.x + b.x - c.x, a.y + b.y - c.y};

                    for (int l = 0; l < pointsSize; l++) {
                        if (l == i || l == j || l == k) continue;
                        if (p[l].x == d.x && p[l].y == d.y) {
                            double area = sqrt(cax * cax + cay * cay) * sqrt(cbx * cbx + cby * cby);
                            if (min_area < 0 || area < min_area) {
                                min_area = area;
                            }
                        }
                    }
                }
            }
        }
    }

    free(p);
    return min_area < 0 ? 0.0 : min_area;
}