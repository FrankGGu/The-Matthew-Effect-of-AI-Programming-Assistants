#include <math.h>
#include <stdlib.h> // For malloc, free

typedef struct {
    double x;
    double y;
} DPoint;

double distSq(DPoint p1, DPoint p2) {
    double dx = p1.x - p2.x;
    double dy = p1.y - p2.y;
    return dx * dx + dy * dy;
}

int max(int a, int b) {
    return a > b ? a : b;
}

int numDarts(int** points, int pointsSize, int r) {
    if (pointsSize == 0) {
        return 0;
    }
    if (pointsSize == 1) {
        return 1;
    }

    double radius = (double)r;
    double radiusSq = radius * radius;
    const double EPS = 1e-9; // Epsilon for floating point comparisons

    int max_darts = 1; // At least one dart can always be covered if pointsSize >= 1

    // Convert input points to DPoint for easier calculations
    DPoint* d_points = (DPoint*)malloc(pointsSize * sizeof(DPoint));
    for (int i = 0; i < pointsSize; ++i) {
        d_points[i].x = (double)points[i][0];
        d_points[i].y = (double)points[i][1];
    }

    // Strategy 1: Iterate through each point and consider it as a potential center.
    // This covers cases where the optimal circle is centered at one of the points,
    // or when all points are very close and one point acts as the "most central".
    for (int i = 0; i < pointsSize; ++i) {
        int current_darts = 0;
        for (int k = 0; k < pointsSize; ++k) {
            if (distSq(d_points[i], d_points[k]) <= radiusSq + EPS) {
                current_darts++;
            }
        }
        max_darts = max(max_darts, current_darts);
    }

    // Strategy 2: Iterate through all pairs of points (p_i, p_j).
    // Consider circles of radius r that pass through both p_i and p_j.
    // An optimal circle can always be chosen to have at least two points on its boundary
    // (unless all points are identical, or only one point exists, handled above).
    for (int i = 0; i < pointsSize; ++i) {
        for (int j = i + 1; j < pointsSize; ++j) {
            DPoint p1 = d_points[i];
            DPoint p2 = d_points[j];

            double dx = p2.x - p1.x;
            double dy = p2.y - p1.y;
            double d_sq = dx * dx + dy * dy;
            double d = sqrt(d_sq);

            // If distance between p1 and p2 is greater than 2*r, they cannot both be on the boundary
            // or inside a circle of radius r.
            if (d > 2.0 * radius + EPS) {
                continue;
            }

            // If points are identical or extremely close, skip this pair.
            // This avoids division by zero for 'd' and such cases are already handled by Strategy 1
            // or by pairing with other distinct points.
            if (d < EPS) {
                continue;
            }

            // Calculate midpoint M of p1 and p2
            DPoint mid = {(p1.x + p2.x) / 2.0, (p1.y + p2.y) / 2.0};

            // Distance from M to center C along perpendicular bisector
            // h^2 = r^2 - (d/2)^2
            double h_sq = radiusSq - (d / 2.0) * (d / 2.0);

            // Due to floating point inaccuracies, h_sq might be slightly negative when it should be zero.
            // If h_sq is effectively zero or negative, it means there's only one center (the midpoint)
            // or no valid centers for a circle of radius r passing through both points.
            if (h_sq < EPS) { // Treat as h=0, only one center (midpoint)
                DPoint c = mid;
                int current_darts = 0;
                for (int k = 0; k < pointsSize; ++k) {
                    if (distSq(c, d_points[k]) <= radiusSq + EPS) {
                        current_darts++;
                    }
                }
                max_darts = max(max_darts, current_darts);
                continue; // No second distinct center
            }

            double h = sqrt(h_sq);

            // Unit vector perpendicular to p1p2
            // Vector p1->p2 is (dx, dy). A perpendicular vector is (-dy, dx).
            // Normalize it by dividing by d.
            double vx = -dy / d;
            double vy = dx / d;

            // Calculate the two possible centers
            DPoint c1 = {mid.x + h * vx, mid.y + h * vy};
            DPoint c2 = {mid.x - h * vx, mid.y - h * vy};

            // Count darts for center 1
            int current_darts_c1 = 0;
            for (int k = 0; k < pointsSize; ++k) {
                if (distSq(c1, d_points[k]) <= radiusSq + EPS) {
                    current_darts_c1++;
                }
            }
            max_darts = max(max_darts, current_darts_c1);

            // Count darts for center 2
            int current_darts_c2 = 0;
            for (int k = 0; k < pointsSize; ++k) {
                if (distSq(c2, d_points[k]) <= radiusSq + EPS) {
                    current_darts_c2++;
                }
            }
            max_darts = max(max_darts, current_darts_c2);
        }
    }

    free(d_points);
    return max_darts;
}