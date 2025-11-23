import collections

class Solution:
    def countPairs(self, points: list[list[int]], k: int) -> int:
        point_freq = collections.Counter(tuple(p) for p in points)

        ans = 0

        # Iterate through each unique point (x, y) and its frequency
        for (x1, y1), freq1 in point_freq.items():
            # Iterate through possible absolute differences in x-coordinates (dx)
            # dx can range from 0 to k
            for dx in range(k + 1):
                # The absolute difference in y-coordinates (dy) is then k - dx
                dy = k - dx

                # We need to find points (x2, y2) such that:
                # |x1 - x2| = dx  => x2 = x1 + dx or x2 = x1 - dx
                # |y1 - y2| = dy  => y2 = y1 + dy or y2 = y1 - dy

                # Generate potential target points (x2, y2)
                # Use a set to handle cases where dx=0 or dy=0, which lead to duplicate targets
                target_points = set()

                # Case 1: x2 = x1 + dx, y2 = y1 + dy
                target_points.add((x1 + dx, y1 + dy))

                # Case 2: x2 = x1 + dx, y2 = y1 - dy (only if dy is not 0 to avoid duplicates if y1+dy == y1-dy)
                if dy != 0:
                    target_points.add((x1 + dx, y1 - dy))

                # Case 3: x2 = x1 - dx, y2 = y1 + dy (only if dx is not 0)
                if dx != 0:
                    target_points.add((x1 - dx, y1 + dy))

                # Case 4: x2 = x1 - dx, y2 = y1 - dy (only if dx and dy are not 0)
                if dx != 0 and dy != 0:
                    target_points.add((x1 - dx, y1 - dy))

                # For each potential target point, check if it exists in our frequency map
                for x2, y2 in target_points:
                    if (x2, y2) in point_freq:
                        freq2 = point_freq[(x2, y2)]

                        # If (x1, y1) is the same point as (x2, y2)
                        # This happens when dx=0 and dy=0, meaning k=0
                        # In this case, we count pairs of the same point from its frequency
                        if (x1, y1) == (x2, y2):
                            ans += freq1 * (freq1 - 1)
                        else:
                            # If they are different points, add product of their frequencies
                            ans += freq1 * freq2

        # Each pair (P1, P2) is counted twice (once when P1 is (x1,y1) and once when P2 is (x1,y1))
        # So, divide the total count by 2
        return ans // 2