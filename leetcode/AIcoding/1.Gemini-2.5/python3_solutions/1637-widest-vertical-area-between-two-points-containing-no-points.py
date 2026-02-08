class Solution:
    def maxWidthOfVerticalArea(self, points: list[list[int]]) -> int:
        x_coordinates = sorted(list(set(p[0] for p in points)))

        max_width = 0
        if len(x_coordinates) < 2:
            return 0

        for i in range(1, len(x_coordinates)):
            max_width = max(max_width, x_coordinates[i] - x_coordinates[i-1])

        return max_width