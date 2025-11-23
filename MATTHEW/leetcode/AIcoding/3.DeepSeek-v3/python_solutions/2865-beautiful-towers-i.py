class Solution:
    def maximumSumOfHeights(self, maxHeights: List[int]) -> int:
        n = len(maxHeights)
        res = 0

        for i in range(n):
            total = maxHeights[i]
            left = maxHeights[i]
            for j in range(i - 1, -1, -1):
                left = min(left, maxHeights[j])
                total += left
            right = maxHeights[i]
            for j in range(i + 1, n):
                right = min(right, maxHeights[j])
                total += right
            res = max(res, total)

        return res