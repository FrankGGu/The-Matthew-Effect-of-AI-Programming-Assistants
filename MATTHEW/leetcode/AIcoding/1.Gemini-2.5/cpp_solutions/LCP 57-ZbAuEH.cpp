#include <vector>
#include <cmath>
#include <algorithm>

const double EPS = 1e-9;

struct Point {
    double x, y;

    Point(double _x, double _y) : x(_x), y(_y) {}

    double distSq(const Point& other) const {
        return (x - other.x) * (x - other.x) + (y - other.y) * (y - other.y);
    }
};

class Solution {
public:
    int numMoles(std::vector<std::vector<int>>& points_int, int R_int) {
        if (points_int.empty()) {
            return 0;
        }

        std::vector<Point> points;
        for (const auto& p_int : points_int) {
            points.emplace_back(p_int[0], p_int[1]);
        }

        double R = static_cast<double>(R_int);
        double R_sq = R * R;

        int n = points.size();

        if (n <= 1) {
            return n;
        }

        int max_moles = 1;

        for (int i = 0; i < n; ++i) {
            int current_moles_centered_at_i = 0;
            for (int k = 0; k < n; ++k) {
                if (points[i].distSq(points[k]) <= R_sq + EPS) {
                    current_moles_centered_at_i++;
                }
            }
            max_moles = std::max(max_moles, current_moles_centered_at_i);

            for (int j = i + 1; j < n; ++j) {
                double d_sq = points[i].distSq(points[j]);

                if (d_sq > 4 * R_sq + EPS) {
                    continue;
                }

                double d = std::sqrt(d_sq);

                Point M((points[i].x + points[j].x) / 2.0, (points[i].y + points[j].y) / 2.0);

                double h_sq = R_sq - (d_sq / 4.0);
                double h = std::sqrt(std::max(0.0, h_sq));

                Point V_ij(points[j].x - points[i].x, points[j].y - points[i].y);

                Point V_perp(-V_ij.y, V_ij.x);

                double V_perp_len = std::sqrt(V_perp.x * V_perp.x + V_perp.y * V_perp.y);

                if (V_perp_len < EPS) {
                    continue;
                }

                Point V_perp_norm(V_perp.x / V_perp_len, V_perp.y / V_perp_len);

                Point C1(M.x + h * V_perp_norm.x, M.y + h * V_perp_norm.y);
                Point C2(M.x - h * V_perp_norm.x, M.y - h * V_perp_norm.y);

                int current_moles_C1 = 0;
                for (int k = 0; k < n; ++k) {
                    if (C1.distSq(points[k]) <= R_sq + EPS) {
                        current_moles_C1++;
                    }
                }
                max_moles = std::max(max_moles, current_moles_C1);

                int current_moles_C2 = 0;
                for (int k = 0; k < n; ++k) {
                    if (C2.distSq(points[k]) <= R_sq + EPS) {
                        current_moles_C2++;
                    }
                }
                max_moles = std::max(max_moles, current_moles_C2);
            }
        }

        return max_moles;
    }
};