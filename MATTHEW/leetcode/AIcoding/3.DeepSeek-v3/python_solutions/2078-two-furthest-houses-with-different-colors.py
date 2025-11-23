class Solution:
    def maxDistance(self, colors: List[int]) -> int:
        n = len(colors)
        max_dist = 0
        for i in range(n):
            for j in range(i + 1, n):
                if colors[i] != colors[j]:
                    max_dist = max(max_dist, j - i)
        return max_dist