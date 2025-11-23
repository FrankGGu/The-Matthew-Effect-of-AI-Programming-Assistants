class Solution:
    def countPoints(self, points: List[List[int]], queries: List[List[int]]) -> List[int]:
        result = []
        for x_center, y_center, radius in queries:
            count = sum((x - x_center) ** 2 + (y - y_center) ** 2 <= radius ** 2 for x, y in points)
            result.append(count)
        return result