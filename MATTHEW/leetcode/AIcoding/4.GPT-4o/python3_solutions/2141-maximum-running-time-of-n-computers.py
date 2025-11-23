class Solution:
    def maxRunTime(self, n: int, batteries: List[int]) -> int:
        left, right = 1, sum(batteries) // n

        while left < right:
            mid = (left + right + 1) // 2
            if sum(min(b, mid) for b in batteries) >= mid * n:
                left = mid
            else:
                right = mid - 1

        return left