class Solution:
    def minimumBox(self, n: int) -> int:
        left, right = 1, n
        while left < right:
            mid = (left + right) // 2
            total = mid * (mid + 1) * (mid + 2) // 6
            if total < n:
                left = mid + 1
            else:
                right = mid
        return left