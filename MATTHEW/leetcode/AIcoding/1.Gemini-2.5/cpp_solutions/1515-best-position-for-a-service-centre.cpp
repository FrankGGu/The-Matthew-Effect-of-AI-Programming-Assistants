#include <vector>
#include <cmath>
#include <iomanip>

class Solution {
public:
    double getMinDistSum(std::vector<std::vector<int>>& points) {
        double current_x = 0.0;
        double current_y = 0.0;
        int n = points.size();

        if (n == 0) {
            return 0.0;
        }

        for (const auto& p : points) {
            current_x += p[0];
            current_y += p[1];
        }
        current_x /= n;
        current_y /= n;

        double delta = 100.0; 
        double epsilon = 1e-7; 

        double min_dist_sum = calculateTotalDistance(current_x, current_y, points);

        double dx[] = {0, 0, 1, -1, 1, 1, -1, -1};
        double dy[] = {1, -1, 0, 0, 1, -1, 1, -1};

        while (delta > epsilon) {
            bool found_better = false;
            for (int i = 0; i < 8; ++i) {
                double next_x = current_x + delta * dx[i];
                double next_y = current_y + delta * dy[i];

                double new_dist_sum = calculateTotalDistance(next_x, next_y, points);

                if (new_dist_sum < min_dist_sum) {
                    min_dist_sum = new_dist_sum;
                    current_x = next_x;
                    current_y = next_y;
                    found_better = true;
                }
            }

            if (!found_better) {
                delta /= 2.0;
            }
        }

        return min_dist_sum;
    }

private:
    double calculateTotalDistance(double x, double y, const std::vector<std::vector<int>>& points) {
        double total_distance = 0.0;
        for (const auto& p : points) {
            double dx_val = x - p[0];
            double dy_val = y - p[1];
            total_distance += std::sqrt(dx_val * dx_val + dy_val * dy_val);
        }
        return total_distance;
    }
};