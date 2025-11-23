class Solution:
    def stableMountains(self, heights: List[int]) -> List[int]:
        n = len(heights)
        result = []

        for i in range(1, n - 1):
            if heights[i] > heights[i - 1] and heights[i] > heights[i + 1]:
                result.append(i)
            elif heights[i] < heights[i - 1] and heights[i] < heights[i + 1]:
                result.append(i)

        return result