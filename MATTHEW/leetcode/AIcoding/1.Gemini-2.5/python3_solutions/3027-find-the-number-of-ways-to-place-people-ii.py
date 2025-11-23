class Solution:
    def numberOfPairs(self, points: list[list[int]]) -> int:
        # Step 1: Remove duplicate points and sort them.
        # Convert points to tuples for set uniqueness, then back to list of lists.
        # Sort by x-coordinate ascending, then y-coordinate ascending.
        # This ensures that for any i < j, unique_points[i][0] <= unique_points[j][0].
        unique_points = sorted(list(set(tuple(p) for p in points)))

        n = len(unique_points)
        ans = 0

        # Iterate through each point as p1 (potential bottom-left corner)
        for i in range(n):
            x1, y1 = unique_points[i]

            # max_y_in_rect_candidate tracks the maximum y-coordinate of any point p_k
            # that has been encountered between p1 and the current p2 (i.e., for k such that i < k < j),
            # AND whose y-coordinate is greater than or equal to y1.
            # This variable helps check the "no other point p3" condition.
            # Initialize with -1, as y-coordinates are non-negative.
            max_y_in_rect_candidate = -1 

            # Iterate through points to the right of p1 as p2 (potential top-right corner)
            for j in range(i + 1, n):
                x2, y2 = unique_points[j]

                # Condition 1 check: x1 <= x2 and y1 <= y2
                # x1 <= x2 is guaranteed because unique_points is sorted by x then y, and j > i.
                # If y2 < y1, then p2 is below p1 (or at same x, lower y).
                # Such a p2 cannot be a top-right corner for p1.
                # Also, if y2 < y1, p2 cannot obstruct any valid pair (p1, p_prime)
                # where p_prime has y_prime >= y1, because for obstruction, p2's y-coordinate
                # would need to be between y1 and y_prime, which contradicts y2 < y1.
                if y2 < y1:
                    continue

                # At this point, x1 <= x2 and y1 <= y2. Condition 1 is satisfied.

                # Now check Condition 2: There is no other point p3 = (x3, y3) such that
                # x1 <= x3 <= x2 and y1 <= y3 <= y2, and p3 is not p1 or p2.
                # For any point p_k = unique_points[k] where i < k < j:
                # Due to sorting, we know x1 <= x_k <= x2.
                # So, p_k obstructs (p1, p2) if and only if y1 <= y_k <= y2.
                # max_y_in_rect_candidate stores the maximum y_k for such p_k that also satisfy y_k >= y1.
                # If max_y_in_rect_candidate is -1, it means no point p_k (with i < k < j)
                # had a y-coordinate >= y1. Thus, no obstruction in the y-range [y1, y2].
                # If max_y_in_rect_candidate > y2, it means all relevant p_k (with y_k >= y1)
                # are strictly above p2's y-level. Thus, no obstruction in the y-range [y1, y2].
                # In both these cases, (p1, p2) is a valid pair.
                if max_y_in_rect_candidate == -1 or max_y_in_rect_candidate > y2:
                    ans += 1

                # Update max_y_in_rect_candidate for the next iteration (j+1).
                # The current point unique_points[j] itself could be an obstructing point
                # for future p2's (e.g., if p2_prime = unique_points[j+1]).
                # We only consider points whose y-coordinate is >= y1 for this tracking.
                max_y_in_rect_candidate = max(max_y_in_rect_candidate, y2)

        return ans