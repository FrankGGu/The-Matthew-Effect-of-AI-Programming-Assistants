import math

class Solution:
    def countPoints(self, points: list[list[int]], queries: list[list[int]]) -> list[int]:
        results = []
        for cx, cy, r in queries:
            count = 0
            r_squared = r * r
            for px, py in points:
                dist_squared = (px - cx)**2 + (py - cy)**2
                if dist_squared <= r_squared:
                    count += 1
            results.append(count)
        return results