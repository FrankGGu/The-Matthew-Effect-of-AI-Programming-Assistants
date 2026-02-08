import collections
import math
from bisect import bisect_left

class Solution:
    def maximizeArea(self, points: list[list[int]], k: int) -> int:
        n = len(points)

        if k == 0:
            return 0

        if k > n:
            return 0

        # Special handling for k=1: The largest rectangle containing at least one point
        # is typically the bounding box of all points.
        # If k=1 and all points are distinct, the general O(N^3) logic would yield 0
        # because (y_m - y_m) = 0.
        if k == 1:
            if n == 0:
                return 0
            min_x = float('inf')
            max_x = float('-inf')
            min_y = float('inf')
            max_y = float('-inf')
            for px, py in points:
                min_x = min(min_x, px)
                max_x = max(max_x, px)
                min_y = min(min_y, py)
                max_y = max(max_y, py)
            return (max_x - min_x) * (max_y - min_y)

        # General case for k > 1
        # Sort points by x-coordinate to enable sweep-line approach
        points.sort()

        max_area = 0

        # Iterate through all possible pairs of x-coordinates (left and right boundaries)
        for i in range(n):
            # points[i] defines the leftmost x-coordinate of the candidate rectangle

            # active_y_coords will store y-coordinates of points whose x-coordinates
            # are between points[i][0] and points[j][0], sorted.
            active_y_coords = []

            for j in range(i, n):
                # points[j] defines the rightmost x-coordinate of the candidate rectangle

                # Add points[j]'s y-coordinate to the active list, maintaining sorted order.
                # bisect_left finds the insertion point, and list.insert performs the insertion.
                # This operation is O(M) where M is len(active_y_coords).
                y_val = points[j][1]
                idx = bisect_left(active_y_coords, y_val)
                active_y_coords.insert(idx, y_val)

                # If we have at least k points in the current x-strip (between points[i][0] and points[j][0])
                if len(active_y_coords) >= k:
                    current_width = points[j][0] - points[i][0]

                    # Find the maximum height using a sliding window of size k on active_y_coords.
                    # This finds the minimum bounding height for k points within the strip.
                    max_height_in_strip = 0
                    for m in range(len(active_y_coords) - k + 1):
                        height = active_y_coords[m + k - 1] - active_y_coords[m]
                        max_height_in_strip = max(max_height_in_strip, height)

                    # Update max_area
                    max_area = max(max_area, current_width * max_height_in_strip)

        return max_area