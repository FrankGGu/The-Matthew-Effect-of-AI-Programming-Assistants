#include <vector>
#include <set>
#include <algorithm> // For std::min
#include <climits>   // For INT_MAX
#include <cmath>     // For std::abs

class Solution {
public:
    int minAreaRect(std::vector<std::vector<int>>& points) {
        std::set<long long> point_set;
        // A constant larger than max coordinate value (40000)
        // Used for hashing (x, y) into a single long long.
        // max_coord + 1 ensures unique hash for unique (x, y) pairs.
        const int COORD_MAX = 40000;
        const long long HASH_MULTIPLIER = COORD_MAX + 1;

        for (const auto& p : points) {
            point_set.insert((long long)p[0] * HASH_MULTIPLIER + p[1]);
        }

        int minArea = INT_MAX;

        // Iterate through all unique pairs of points
        for (int i = 0; i < points.size(); ++i) {
            for (int j = i + 1; j < points.size(); ++j) {
                int x1 = points[i][0];
                int y1 = points[i][1];
                int x2 = points[j][0];
                int y2 = points[j][1];

                // If points share the same x or y coordinate, they cannot form a diagonal
                // of an axis-aligned rectangle.
                if (x1 == x2 || y1 == y2) {
                    continue;
                }

                // Potential other two corners are (x1, y2) and (x2, y1).
                // Check if these points exist in the original set.
                long long p3_hash = (long long)x1 * HASH_MULTIPLIER + y2;
                long long p4_hash = (long long)x2 * HASH_MULTIPLIER + y1;

                if (point_set.count(p3_hash) && point_set.count(p4_hash)) {
                    // Found a rectangle. Calculate its area.
                    int currentArea = std::abs(x1 - x2) * std::abs(y1 - y2);
                    minArea = std::min(minArea, currentArea);
                }
            }
        }

        // If minArea is still INT_MAX, it means no rectangle was found.
        return (minArea == INT_MAX) ? 0 : minArea;
    }
};