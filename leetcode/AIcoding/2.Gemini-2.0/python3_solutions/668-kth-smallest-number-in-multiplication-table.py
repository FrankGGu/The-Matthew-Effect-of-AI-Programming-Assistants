class Solution:
    def findKthNumber(self, m: int, n: int, k: int) -> int:
        def count(x):
            cnt = 0
            for i in range(1, m + 1):
                cnt += min(x // i, n)
            return cnt

        low, high = 1, m * n
        while low < high:
            mid = (low + high) // 2
            if count(mid) < k:
                low = mid + 1
            else:
                high = mid
        return low