#include <vector>
#include <algorithm>
#include <cmath>

class Solution {
public:
    long long largestSquareArea(std::vector<int>& rect1, std::vector<int>& rect2) {
        long long x1_min = rect1[0];
        long long y1_min = rect1[1];
        long long x1_max = rect1[2];
        long long y1_max = rect1[3];

        long long x2_min = rect2[0];
        long long y2_min = rect2[1];
        long long x2_max = rect2[2];
        long long y2_max = rect2[3];

        // Calculate the range of possible side lengths 's' for x-coordinates.
        // A side length 's' is possible if there exist px1 in [x1_min, x1_max]
        // and px2 in [x2_min, x2_max] such that abs(px1 - px2) = s.

        // min_s_x: The minimum possible non-negative absolute difference |px1 - px2|.
        // This is 0 if the x-intervals overlap, or the distance between the closest endpoints if they don't.
        long long min_s_x = std::max({0LL, x1_min - x2_max, x2_min - x1_max});

        // max_s_x: The maximum possible absolute difference |px1 - px2|.
        // This is the maximum of the absolute differences between any endpoint from rect1's x-range
        // and any endpoint from rect2's x-range.
        // The range of (px1 - px2) is [x1_min - x2_max, x1_max - x2_min].
        // The maximum absolute value in this range is max(abs(x1_min - x2_max), abs(x1_max - x2_min)).
        long long max_s_x = std::max(std::abs(x1_min - x2_max), std::abs(x1_max - x2_min));

        // Calculate the range of possible side lengths 's' for y-coordinates similarly.
        long long min_s_y = std::max({0LL, y1_min - y2_max, y2_min - y1_max});
        long long max_s_y = std::max(std::abs(y1_min - y2_max), std::abs(y1_max - y2_min));

        // A valid side length 's' must satisfy both x and y constraints.
        // So, 's' must be in the intersection of [min_s_x, max_s_x] and [min_s_y, max_s_y].
        long long final_min_s = std::max(min_s_x, min_s_y);
        long long final_max_s = std::min(max_s_x, max_s_y);

        // If the calculated common range is invalid (lower bound > upper bound),
        // it means no such square can be formed.
        if (final_min_s > final_max_s) {
            return 0;
        }

        // The largest possible side length 's' is the upper bound of the common range.
        long long largest_s = final_max_s;
        return largest_s * largest_s;
    }
};