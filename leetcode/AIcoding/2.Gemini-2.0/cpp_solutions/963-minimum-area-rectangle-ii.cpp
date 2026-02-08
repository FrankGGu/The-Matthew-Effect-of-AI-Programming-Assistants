#include <vector>
#include <unordered_map>
#include <cmath>
#include <iomanip>

using namespace std;

struct Point {
    int x, y;
};

double distance(Point p1, Point p2) {
    return sqrt(pow(p1.x - p2.x, 2) + pow(p1.y - p2.y, 2));
}

double cross_product(Point a, Point b, Point c) {
    return (double)(b.x - a.x) * (c.y - a.y) - (double)(b.y - a.y) * (c.x - a.x);
}

double minAreaFreeRect(vector<vector<int>>& points) {
    int n = points.size();
    vector<Point> pts(n);
    for (int i = 0; i < n; ++i) {
        pts[i].x = points[i][0];
        pts[i].y = points[i][1];
    }

    double min_area = 1e18;

    for (int i = 0; i < n; ++i) {
        for (int j = i + 1; j < n; ++j) {
            for (int k = j + 1; k < n; ++k) {
                double dist_ij = distance(pts[i], pts[j]);
                double dist_ik = distance(pts[i], pts[k]);

                double cross = cross_product(pts[i], pts[j], pts[k]);

                if (abs(cross) < 1e-6) continue;

                Point p4;
                p4.x = pts[j].x + pts[k].x - pts[i].x;
                p4.y = pts[j].y + pts[k].y - pts[i].y;

                bool found = false;
                for (int l = 0; l < n; ++l) {
                    if (l != i && l != j && l != k && pts[l].x == p4.x && pts[l].y == p4.y) {
                        found = true;
                        break;
                    }
                }

                if (found) {
                    double area = dist_ij * dist_ik;
                    min_area = min(min_area, area);
                }
            }
        }
    }

    if (min_area > 1e17) return 0;
    return min_area;
}