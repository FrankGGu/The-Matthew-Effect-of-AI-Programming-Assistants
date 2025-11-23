class Solution:
    def countRectangles(self, rectangles: List[List[int]], points: List[List[int]]) -> List[int]:
        from collections import defaultdict
        rectangle_count = defaultdict(int)

        for x, y in rectangles:
            rectangle_count[(x, y)] += 1

        result = []
        for px, py in points:
            count = 0
            for (x, y), c in rectangle_count.items():
                if x >= px and y >= py:
                    count += c
            result.append(count)

        return result