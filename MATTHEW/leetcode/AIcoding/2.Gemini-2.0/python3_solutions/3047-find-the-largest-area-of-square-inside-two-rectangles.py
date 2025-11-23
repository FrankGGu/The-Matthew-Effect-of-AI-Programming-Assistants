class Solution:
    def largestArea(self, bottomLeft: list[list[int]], topRight: list[list[int]]) -> int:
        x1 = max(bottomLeft[0][0], bottomLeft[1][0])
        y1 = max(bottomLeft[0][1], bottomLeft[1][1])
        x2 = min(topRight[0][0], topRight[1][0])
        y2 = min(topRight[0][1], topRight[1][1])

        if x1 >= x2 or y1 >= y2:
            return 0

        side = min(x2 - x1, y2 - y1)
        return side * side