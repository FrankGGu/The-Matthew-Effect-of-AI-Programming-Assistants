class Solution:
    def findKthNumber(self, m: int, n: int, k: int) -> int:
        left, right = 1, m * n

        def count_less_or_equal(x):
            count = 0
            for i in range(1, m + 1):
                add = min(x // i, n)
                if add == 0:
                    break
                count += add
            return count

        while left < right:
            mid = (left + right) // 2
            if count_less_or_equal(mid) < k:
                left = mid + 1
            else:
                right = mid
        return left