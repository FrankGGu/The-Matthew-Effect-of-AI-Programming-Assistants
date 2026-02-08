class Solution:
    def findKthNumber(self, m: int, n: int, k: int) -> int:

        def count_le(x: int) -> int:
            count = 0
            for i in range(1, m + 1):
                count += min(n, x // i)
            return count

        low = 1
        high = m * n
        ans = m * n

        while low <= high:
            mid = low + (high - low) // 2

            if count_le(mid) >= k:
                ans = mid
                high = mid - 1
            else:
                low = mid + 1

        return ans