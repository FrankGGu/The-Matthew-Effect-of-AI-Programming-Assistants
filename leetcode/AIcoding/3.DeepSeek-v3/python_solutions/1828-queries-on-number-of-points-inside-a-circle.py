class Solution:
    def countPoints(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        res = []
        for x, y, r in queries:
            count = 0
            r_squared = r * r
            for px, py in points:
                dx = px - x
                dy = py - y
                if dx * dx + dy * dy <= r_squared:
                    count += 1
            res.append(count)
        return res