#include <vector>
#include <algorithm>
#include <climits>

class Solution {
public:
    long long maxManhattanDistance(std::vector<std::vector<int>>& points, int k) {
        int n = points.size();

        if (n <= k) {
            // If we can change all points (or more than all points),
            // we can make two points have coordinates (10^9, 10^9) and (-10^9, -10^9).
            // The Manhattan distance between these two points would be
            // |10^9 - (-10^9)| + |10^9 - (-10^9)| = 2*10^9 + 2*10^9 = 4*10^9.
            // This is the maximum possible Manhattan distance given the coordinate range.
            return 4LL * 1000000000;
        }

        std::vector<long long> u_vals(n); // Stores x + y for each point
        std::vector<long long> v_vals(n); // Stores x - y for each point

        for (int i = 0; i < n; ++i) {
            u_vals[i] = (long long)points[i][0] + points[i][1];
            v_vals[i] = (long long)points[i][0] - points[i][1];
        }

        // Sort the transformed coordinate values
        std::sort(u_vals.begin(), u_vals.end());
        std::sort(v_vals.begin(), v_vals.end());

        long long max_u_diff = 0;
        // To maximize (max(u) - min(u)) after changing K points,
        // we can remove 'i' smallest u_vals and 'k-i' largest u_vals.
        // The remaining N-K points will form a contiguous subsegment in the sorted array.
        // We iterate 'i' from 0 to K to consider all possibilities.
        for (int i = 0; i <= k; ++i) {
            // The smallest remaining u_val is u_vals[i].
            // The largest remaining u_val is u_vals[n - 1 - (k - i)].
            // This is equivalent to u_vals[n - 1 - k + i].
            max_u_diff = std::max(max_u_diff, u_vals[n - 1 - k + i] - u_vals[i]);
        }

        long long max_v_diff = 0;
        // Apply the same logic for v_vals.
        for (int i = 0; i <= k; ++i) {
            max_v_diff = std::max(max_v_diff, v_vals[n - 1 - k + i] - v_vals[i]);
        }

        // The maximum Manhattan distance is the maximum of the ranges for u_vals and v_vals.
        return std::max(max_u_diff, max_v_diff);
    }
};