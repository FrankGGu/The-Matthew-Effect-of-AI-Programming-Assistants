class Solution:
    def maxBuilding(self, heights: List[List[int]]) -> int:
        heights.sort()
        n = len(heights)
        for i in range(1, n):
            heights[i][1] = max(heights[i][1], heights[i - 1][1] + heights[i][0] - heights[i - 1][0])
        for i in range(n - 2, -1, -1):
            heights[i][1] = max(heights[i][1], heights[i + 1][1] + heights[i][0] - heights[i + 1][0])

        max_height = 0
        for i in range(n - 1):
            left = heights[i][0]
            right = heights[i + 1][0]
            max_height = max(max_height, (heights[i][1] + heights[i + 1][1] + right - left) // 2)

        return max(max_height, max(heights[0][1], heights[-1][1]))