class Solution:
    def minAreaRect(self, rect: List[List[int]]) -> int:
        points = set()
        for x, y in rect:
            points.add((x, y))
        min_area = float('inf')
        for i in range(len(rect)):
            x1, y1 = rect[i]
            for j in range(i + 1, len(rect)):
                x2, y2 = rect[j]
                if (x1, y2) in points and (x2, y1) in points:
                    area = abs(x1 - x2) * abs(y1 - y2)
                    min_area = min(min_area, area)
        return min_area if min_area != float('inf') else 0