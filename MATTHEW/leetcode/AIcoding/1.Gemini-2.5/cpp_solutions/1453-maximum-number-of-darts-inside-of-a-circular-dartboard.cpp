#include <vector>
#include <cmath>
#include <algorithm>

const double EPS = 1e-9;

struct Point {
    double x, y;
};

double distSq(const Point& p1, const Point& p2) {
    return (p1.x - p2.x) * (p1.x - p2.x) + (p1.y - p2.y) * (p1.y - p2.y);
}

class Solution {
public:
    int numDarts(std::vector<std::vector<int>>& points_int, int r_int) {
        int n = points_int.size();
        if (n == 0) {
            return 0;
        }
        if (n == 1) {
            return 1;
        }

        std::vector<Point> points(n);
        for (int i = 0; i < n; ++i) {
            points[i] = {(double)points_int[i][0], (double)points_int[i][1]};
        }
        double r = (double)r_int;
        double r_sq = r * r;

        int max_darts = 1;

        // Case 1: Consider each point as a potential center of the dartboard.
        // This covers cases where the optimal circle is centered at one of the darts,
        // including the case where all darts are identical.
        for (int i = 0; i < n; ++i) {
            int current_darts = 0;
            for (int k = 0; k < n; ++k) {
                if (distSq(points[i], points[k]) <= r_sq + EPS) {
                    current_darts++;
                }
            }
            max_darts = std::max(max_darts, current_darts);
        }

        // Case 2: Consider circles whose boundary passes through two distinct darts.
        for (int i = 0; i < n; ++i) {
            for (int j = i + 1; j < n; ++j) {
                double d_sq = distSq(points[i], points[j]);
                double d = std::sqrt(d_sq);

                // If points are too far apart, no circle of radius r can contain both.
                if (d > 2.0 * r + EPS) {
                    continue;
                }

                // If points are identical or very close, they don't uniquely define two centers.
                // This case is handled by the first loop (Case 1).
                if (d < EPS) {
                    continue;
                }

                // Calculate the distance from the midpoint to the center of the circle
                // h = sqrt(r^2 - (d/2)^2)
                double h_sq = r_sq - (d_sq / 4.0);
                // Due to floating point errors, h_sq might be slightly negative. Clamp it.
                if (h_sq < 0) {
                    h_sq = 0;
                }
                double h = std::sqrt(h_sq);

                // Midpoint M of P_i and P_j
                Point M = {(points[i].x + points[j].x) / 2.0, (points[i].y + points[j].y) / 2.0};

                // Vector from P_i to P_j
                Point v = {points[j].x - points[i].x, points[j].y - points[i].y};

                // Perpendicular unit vector to v
                Point u_perp = {-v.y / d, v.x / d};

                // Two possible centers C1 and C2
                Point C1 = {M.x + h * u_perp.x, M.y + h * u_perp.y};
                Point C2 = {M.x - h * u_perp.x, M.y - h * u_perp.y};

                // Count darts for C1
                int current_darts_C1 = 0;
                for (int k = 0; k < n; ++k) {
                    if (distSq(C1, points[k]) <= r_sq + EPS) {
                        current_darts_C1++;
                    }
                }
                max_darts = std::max(max_darts, current_darts_C1);

                // Count darts for C2
                int current_darts_C2 = 0;
                for (int k = 0; k < n; ++k) {
                    if (distSq(C2, points[k]) <= r_sq + EPS) {
                        current_darts_C2++;
                    }
                }
                max_darts = std::max(max_darts, current_darts_C2);
            }
        }

        return max_darts;
    }
};