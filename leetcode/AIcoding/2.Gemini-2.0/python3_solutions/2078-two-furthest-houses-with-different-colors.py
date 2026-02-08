class Solution:
    def maxDistance(self, colors: list[int]) -> int:
        n = len(colors)
        max_dist = 0
        for i in range(n):
            for j in range(n - 1, i, -1):
                if colors[i] != colors[j]:
                    max_dist = max(max_dist, j - i)
                    break
        return max_dist