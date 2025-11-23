class Solution:
    def maxPointsInsideSquare(self, points: List[List[int]], s: str) -> int:
        from collections import defaultdict

        min_dist = defaultdict(lambda: float('inf'))
        for (x, y), c in zip(points, s):
            dist = max(abs(x), abs(y))
            if dist < min_dist[c]:
                min_dist[c] = dist

        if len(min_dist) < len(set(s)):
            return 0

        sorted_dists = sorted(min_dist.values())
        max_k = 0
        for i in range(len(sorted_dists)):
            if i == 0:
                if sorted_dists[i] > 0:
                    max_k = 1
            else:
                if sorted_dists[i] > sorted_dists[i-1]:
                    max_k = i + 1
                else:
                    break

        return max_k