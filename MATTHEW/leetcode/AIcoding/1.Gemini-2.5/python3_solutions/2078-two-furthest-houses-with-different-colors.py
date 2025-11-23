class Solution:
    def maxDistance(self, colors: list[int]) -> int:
        n = len(colors)
        max_dist = 0

        # Check distances from the leftmost house (index 0)
        # Iterate from the right end towards the left
        for j in range(n - 1, 0, -1):
            if colors[0] != colors[j]:
                max_dist = max(max_dist, j)
                break  # Found the furthest house with a different color from index 0

        # Check distances from the rightmost house (index n-1)
        # Iterate from the left end towards the right
        for i in range(0, n - 1):
            if colors[n - 1] != colors[i]:
                max_dist = max(max_dist, (n - 1) - i)
                break  # Found the furthest house with a different color from index n-1

        return max_dist