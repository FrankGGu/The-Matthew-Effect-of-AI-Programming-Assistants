class Solution:
    def maxPoints(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        res = []
        for q in queries:
            x, y, r = q
            count = 0
            for p in points:
                px, py = p
                if (px - x) ** 2 + (py - y) ** 2 <= r * r:
                    count += 1
            res.append(count)
        return res