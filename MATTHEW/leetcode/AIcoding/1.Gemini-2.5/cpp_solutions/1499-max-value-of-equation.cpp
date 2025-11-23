#include <vector>
#include <deque>
#include <algorithm> // For std::max
#include <limits>    // For std::numeric_limits<int>::min()

class Solution {
public:
    int findMaxValueOfEquation(std::vector<std::vector<int>>& points, int k) {
        int max_val = std::numeric_limits<int>::min();

        std::deque<std::pair<int, int>> dq; // Stores {yi - xi, xi}

        for (const auto& point_j : points) {
            int xj = point_j[0];
            int yj = point_j[1];

            while (!dq.empty() && xj - dq.front().second > k) {
                dq.pop_front();
            }

            if (!dq.empty()) {
                max_val = std::max(max_val, yj + xj + dq.front().first);
            }

            int current_y_minus_x = yj - xj;
            while (!dq.empty() && dq.back().first <= current_y_minus_x) {
                dq.pop_back();
            }
            dq.push_back({current_y_minus_x, xj});
        }

        return max_val;
    }
};