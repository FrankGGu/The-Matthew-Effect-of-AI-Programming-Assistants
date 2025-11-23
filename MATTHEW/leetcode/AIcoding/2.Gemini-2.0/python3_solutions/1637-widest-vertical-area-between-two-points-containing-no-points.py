class Solution:
    def maxWidthOfVerticalArea(self, points: List[List[int]]) -> int:
        x_coordinates = sorted([point[0] for point in points])
        max_width = 0
        for i in range(1, len(x_coordinates)):
            max_width = max(max_width, x_coordinates[i] - x_coordinates[i - 1])
        return max_width