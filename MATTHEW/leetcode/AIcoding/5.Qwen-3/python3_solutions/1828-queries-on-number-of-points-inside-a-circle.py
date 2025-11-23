class Solution:
    def countPoints(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        res = []
        for q in queries:
            x, y, r = q
            count = 0
            for p in points:
                dx = p[0] - x
                dy = p[1] - y
                if dx * dx + dy * dy <= r * r:
                    count += 1
            res.append(count)
        return res