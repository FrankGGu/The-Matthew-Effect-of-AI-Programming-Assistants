class Solution:
    def findValley(self, height: list[int]) -> list[int]:
        n = len(height)
        ans = [-1, -1]
        for i in range(1, n - 1):
            if height[i] < height[i - 1] and height[i] < height[i + 1]:
                ans = [i - 1, i + 1]
                break
        return ans

    def findPeak(self, height: list[int]) -> list[int]:
        n = len(height)
        ans = [-1, -1]
        for i in range(1, n - 1):
            if height[i] > height[i - 1] and height[i] > height[i + 1]:
                ans = [i - 1, i + 1]
                break
        return ans