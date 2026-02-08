class Solution:
    def findBuilding(self, heights: List[int]) -> int:
        n = len(heights)
        left = [0] * n
        right = [0] * n

        for i in range(1, n):
            if heights[i] > heights[i - 1]:
                left[i] = left[i - 1] + 1

        for i in range(n - 2, -1, -1):
            if heights[i] > heights[i + 1]:
                right[i] = right[i + 1] + 1

        max_meet = -1
        result = -1

        for i in range(n):
            if left[i] > 0 and right[i] > 0:
                if left[i] + right[i] > max_meet:
                    max_meet = left[i] + right[i]
                    result = i + 1

        return result