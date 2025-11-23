class Solution:
    def countPoints(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        result = []
        for cx, cy, r in queries:
            count = 0
            for px, py in points:
                if (px - cx)**2 + (py - cy)**2 <= r**2:
                    count += 1
            result.append(count)
        return result