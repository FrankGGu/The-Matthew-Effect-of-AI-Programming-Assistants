class Solution:
    def maximumSumOfHeights(self, maxHeights: list[int]) -> int:
        n = len(maxHeights)
        ans = 0
        for i in range(n):
            cur = 0
            peak = maxHeights[i]
            cur += peak
            left = peak
            for j in range(i - 1, -1, -1):
                left = min(left, maxHeights[j])
                cur += left
            right = peak
            for j in range(i + 1, n):
                right = min(right, maxHeights[j])
                cur += right
            ans = max(ans, cur)
        return ans