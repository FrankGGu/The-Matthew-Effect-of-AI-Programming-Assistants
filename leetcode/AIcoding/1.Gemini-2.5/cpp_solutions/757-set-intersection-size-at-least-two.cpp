#include <vector>
#include <algorithm>
#include <climits> // For INT_MIN, though -1 is sufficient for non-negative coordinates

class Solution {
public:
    int intersectionSizeTwo(std::vector<std::vector<int>>& intervals) {
        // Sort intervals by their end points in ascending order.
        // If end points are equal, sort by start points in descending order.
        // This sorting strategy is crucial for the greedy approach.
        // Processing intervals with earlier end points first allows us to make greedy choices
        // that cover them and potentially extend to future intervals.
        // For equal end points, sorting by start descending means we process "tighter" intervals first,
        // which are harder to satisfy and whose chosen points are more likely to cover broader intervals
        // ending at the same point.
        std::sort(intervals.begin(), intervals.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            if (a[1] != b[1]) {
                return a[1] < b[1];
            }
            return a[0] > b[0];
        });

        int ans = 0;
        // p1: the largest point chosen so far that is part of our intersection set S.
        // p2: the second largest point chosen so far that is part of our intersection set S.
        // Initialize with values smaller than any possible interval coordinate (0 <= start_i).
        int p1 = -1; 
        int p2 = -1;

        for (const auto& interval : intervals) {
            int s = interval[0];
            int e = interval[1];

            // Check how many of our current two largest points (p1, p2) cover the current interval [s, e].
            // A point `p` covers [s, e] if `s <= p <= e`.
            // Since intervals are sorted by end points, `p1 <= e_prev <= e` for relevant `p1, p2`.
            // So we only need to check `s <= p`.

            // Case 1: Neither p1 nor p2 cover the current interval [s, e].
            // This happens if `s` is greater than `p1` (the largest point).
            // Since `p2 < p1`, if `s > p1`, then `s > p2` is also true.
            if (s > p1) {
                // We need to add two new points to S.
                // To maximize their utility for future intervals (which have larger end points),
                // we choose the two largest possible points within [s, e]: `e-1` and `e`.
                ans += 2;
                p1 = e;
                p2 = e - 1;
            } 
            // Case 2: Only p1 covers the current interval [s, e].
            // This happens if `s` is greater than `p2` (second largest) but less than or equal to `p1`.
            // (`s <= p1` ensures `p1` is in `[s, e]`, `s > p2` ensures `p2` is not).
            else if (s > p2) {
                // We need to add one more point to S.
                ans += 1;
                // The greedy choice for this new point is `e-1` to maximize future coverage.
                // However, the set S must contain distinct points.
                // If `e-1` is already `p1`, we must choose `e-2` instead.
                int new_point = e - 1;
                if (new_point == p1) {
                    new_point = e - 2;
                }

                // Update p1 and p2 to be the two largest distinct points from `{old_p1, new_point}`.
                // Store the old p1 to correctly compare with new_point.
                int temp_p1 = p1; 
                p1 = std::max(temp_p1, new_point);
                p2 = std::min(temp_p1, new_point);
            }
            // Case 3: Both p1 and p2 cover the current interval [s, e].
            // This happens if `s` is less than or equal to `p2`.
            // (`s <= p2` implies `s <= p1` as well).
            // In this case, the interval is already covered by two distinct points, so we do nothing.
        }

        return ans;
    }
};