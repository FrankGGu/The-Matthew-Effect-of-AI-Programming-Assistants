#include <vector>
#include <algorithm>
#include <set>

struct PointCompare {
    bool operator()(const std::vector<int>& a, const std::vector<int>& b) const {
        if (a[0] != b[0]) {
            return a[0] < b[0];
        }
        return a[1] < b[1];
    }
};

class Solution {
public:
    // Function to compute the cross product of vectors (p1->p2) and (p1->p3).
    // This determines the orientation of the ordered triplet (p1, p2, p3).
    // Returns:
    // > 0 if p1->p2->p3 is a counter-clockwise turn (left turn)
    // < 0 if p1->p2->p3 is a clockwise turn (right turn)
    // = 0 if p1, p2, p3 are collinear
    long long cross_product(const std::vector<int>& p1, const std::vector<int>& p2, const std::vector<int>& p3) {
        return (long long)(p2[0] - p1[0]) * (p3[1] - p1[1]) - (long long)(p2[1] - p1[1]) * (p3[0] - p1[0]);
    }

    std::vector<std::vector<int>> outerTrees(std::vector<std::vector<int>>& trees) {
        int n = trees.size();

        // Handle edge cases: 0, 1, or 2 points are always on the convex hull.
        if (n <= 2) {
            return trees;
        }

        // Sort points lexicographically. This is crucial for the Monotone Chain algorithm.
        std::sort(trees.begin(), trees.end(), PointCompare());

        std::vector<std::vector<int>> hull;

        // Build upper hull
        for (int i = 0; i < n; ++i) {
            // While the last two points in 'hull' and the current point 'trees[i]' form a clockwise turn (right turn),
            // pop the last point from 'hull'. This ensures that 'hull' always maintains a counter-clockwise (left turn)
            // sequence for the upper hull. If points are collinear, they are kept.
            while (hull.size() >= 2 && cross_product(hull[hull.size() - 2], hull.back(), trees[i]) < 0) {
                hull.pop_back();
            }
            hull.push_back(trees[i]);
        }

        // Build lower hull
        // Iterate from the second to last point down to the first point.
        // The first and last points of the sorted 'trees' array (trees[0] and trees[n-1])
        // will be added twice (once for upper, once for lower hull).
        // These duplicates will be removed later.
        for (int i = n - 2; i >= 0; --i) {
            // While the last two points in 'hull' and the current point 'trees[i]' form a clockwise turn (right turn),
            // pop the last point from 'hull'. This ensures a counter-clockwise sequence for the lower hull.
            // Collinear points are kept.
            while (hull.size() >= 2 && cross_product(hull[hull.size() - 2], hull.back(), trees[i]) < 0) {
                hull.pop_back();
            }
            hull.push_back(trees[i]);
        }

        // Remove duplicate points.
        // The hull might contain duplicate points (trees[0] and trees[n-1] are typically added twice).
        // Sort the hull points again to ensure std::unique works correctly, as the order might be mixed
        // from upper and lower hull construction.
        std::sort(hull.begin(), hull.end(), PointCompare());
        hull.erase(std::unique(hull.begin(), hull.end()), hull.end());

        return hull;
    }
};