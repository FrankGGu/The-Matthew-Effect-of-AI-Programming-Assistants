class Solution:
    def maximumNumber(self, k: int, x: int) -> int:
        low = 0
        high = int(2e18)
        ans = 0
        while low <= high:
            mid = (low + high) // 2
            cost = mid * (mid + 1) // 2 - x * sum(1 for i in range(1, int(mid + 1)) if (i & (i - 1)) == 0)
            if cost <= k:
                ans = mid
                low = mid + 1
            else:
                high = mid - 1
        return ans