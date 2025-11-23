class Solution:
    def maximumCandies(self, candies: List[int], k: int) -> int:
        left, right = 1, max(candies)
        res = 0
        while left <= right:
            mid = (left + right) // 2
            total = 0
            for pile in candies:
                total += pile // mid
            if total >= k:
                res = mid
                left = mid + 1
            else:
                right = mid - 1
        return res