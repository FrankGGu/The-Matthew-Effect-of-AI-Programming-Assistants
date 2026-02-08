#include <vector>
#include <algorithm> // For std::sort
#include <limits>    // For std::numeric_limits

class Solution {
public:
    int findMinArrowShots(std::vector<std::vector<int>>& points) {
        if (points.empty()) {
            return 0;
        }

        // Sort balloons by their end coordinates.
        // If end coordinates are the same, the relative order doesn't strictly matter for correctness,
        // but sorting by start coordinate as a tie-breaker is a common practice.
        // For this problem, just sorting by end coordinate is sufficient.
        std::sort(points.begin(), points.end(), [](const std::vector<int>& a, const std::vector<int>& b) {
            return a[1] < b[1];
        });

        int arrows = 0;
        // Initialize lastArrowShotPoint to a very small number (negative infinity)
        // to ensure the first balloon always triggers a new arrow.
        // Use long long to handle potential large coordinate values as per problem constraints.
        long long lastArrowShotPoint = std::numeric_limits<long long>::min(); 

        for (const auto& balloon : points) {
            // If the current balloon's start point is greater than the last arrow's shot point,
            // it means this balloon cannot be burst by the previous arrow.
            // We need a new arrow.
            if (balloon[0] > lastArrowShotPoint) {
                arrows++;
                // Shoot the new arrow at the end point of the current balloon.
                // This greedy choice maximizes the chance of bursting subsequent balloons
                // because it covers the widest possible range to the right.
                lastArrowShotPoint = balloon[1];
            }
            // If balloon[0] <= lastArrowShotPoint, it means the current balloon
            // is covered by the arrow already shot at `lastArrowShotPoint`.
            // No new arrow is needed for this balloon.
        }

        return arrows;
    }
};