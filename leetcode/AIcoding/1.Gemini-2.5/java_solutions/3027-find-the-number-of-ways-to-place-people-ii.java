import java.util.Arrays;
import java.util.Comparator;

class Solution {
    public int numberOfPairs(int[][] points) {
        // Sort points: primarily by x-coordinate in ascending order.
        // If x-coordinates are equal, sort by y-coordinate in descending order.
        // This specific sort order is crucial for the O(N^2) empty rectangle check.
        Arrays.sort(points, (a, b) -> {
            if (a[0] != b[0]) {
                return a[0] - b[0];
            }
            return b[1] - a[1];
        });

        int n = points.length;
        int count = 0;

        // Iterate through each point as a potential bottom-left corner (p1)
        for (int i = 0; i < n; i++) {
            int p1x = points[i][0];
            int p1y = points[i][1];

            // `max_y_interferer` tracks the maximum y-coordinate of any point `points[k]`
            // encountered so far (where `k` is between `i` and `j`) that could potentially
            // interfere with the current `(points[i], points[j])` pair.
            // A point `points[k]` interferes if `p1.x <= points[k].x <= p2.x` and `p1.y <= points[k].y <= p2.y`.
            // Due to the sorting, if `points[k].x == p1.x`, then `points[k].y < p1.y`, so it cannot interfere.
            // Thus, we only care about `points[k]` where `points[k].x > p1.x` and `points[k].y >= p1.y`.
            // Initialize to -1, as y-coordinates are non-negative.
            int max_y_interferer = -1;

            // Iterate through subsequent points as potential top-right corners (p2)
            for (int j = i + 1; j < n; j++) {
                int p2x = points[j][0];
                int p2y = points[j][1];

                // Condition 1: p1.x <= p2.x.
                // This is guaranteed by the primary x-sort for j > i.

                // Condition 2: p1.y <= p2.y.
                if (p2y < p1y) {
                    // If p2.y is less than p1.y, points[j] cannot be the top-right corner for points[i].
                    // Also, this points[j] cannot be an interferer for points[i] (as p3)
                    // because its y-coordinate is below p1.y.
                    continue;
                }

                // If p1.x == p2.x, then due to the y-descending sort for equal x,
                // and the condition p1.y <= p2.y, it must be that p1.y == p2.y.
                // This means points[i] and points[j] are the same coordinate.
                // The problem implies distinct people (p1 != p2). If they are the same, skip.
                if (p2x == p1x) {
                    continue;
                }

                // At this point, we have: p1.x < p2.x and p1.y <= p2.y.
                // This is a candidate pair (p1, p2).
                // Now, check the "no other point p3" condition.
                // We need to ensure that for any point `points[k]` where `i < k < j`:
                //   It's NOT true that `p1.x <= points[k].x <= p2.x` AND `p1.y <= points[k].y <= p2.y`.
                //
                // Due to sorting:
                // - `points[k].x >= p1.x` is always true for `k > i`.
                // - If `points[k].x == p1.x`, then `points[k].y < p1.y` (due to y-descending sort),
                //   so `points[k]` cannot satisfy `points[k].y >= p1.y`. Thus, it cannot interfere.
                // - If `points[k].x > p1.x`:
                //   - If `points[k].x == p2.x`, then `points[k].y > p2.y` (due to y-descending sort,
                //     as `points[k]` comes before `points[j]` for same x).
                //     So `points[k]` cannot satisfy `points[k].y <= p2.y`. Thus, it cannot interfere.
                //   - If `p1.x < points[k].x < p2.x`: these are the only points that can interfere.
                //
                // So, the condition simplifies to: there is no `points[k]` such that
                // `p1.x < points[k].x < p2.x` AND `p1.y <= points[k].y <= p2.y`.
                //
                // `max_y_interferer` stores the maximum `y_k` of points `points[k]` (where `i < k < j`)
                // that satisfy `points[k].x > p1.x` AND `points[k].y >= p1.y`.
                //
                // If `max_y_interferer == -1`, it means no such potential interferer was found between `i` and `j`.
                // If `max_y_interferer > p2y`, it means any potential interferer found so far has a y-coordinate
                // strictly above `p2.y`, so it's outside the rectangle.
                // In both these cases, the rectangle (p1, p2) is "empty".
                // Otherwise (`-1 < max_y_interferer <= p2y`), there is an interferer within the rectangle.
                if (max_y_interferer == -1 || max_y_interferer > p2y) {
                    count++;
                }

                // After checking points[j] as a potential p2, points[j] itself becomes a potential
                // interferer for future p2_primes.
                // Update `max_y_interferer` if `points[j]` is a relevant interferer for `points[i]`.
                // Since we are in the block where `p2x > p1x` and `p2y >= p1y`, `points[j]` is relevant.
                max_y_interferer = Math.max(max_y_interferer, p2y);
            }
        }
        return count;
    }
}