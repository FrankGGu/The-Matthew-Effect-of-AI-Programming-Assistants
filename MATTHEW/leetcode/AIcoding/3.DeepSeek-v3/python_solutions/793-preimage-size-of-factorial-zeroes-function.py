class Solution:
    def preimageSizeFZF(self, k: int) -> int:
        def trailingZeroes(n):
            count = 0
            while n > 0:
                n = n // 5
                count += n
            return count

        left = 0
        right = 5 * (k + 1)
        while left <= right:
            mid = left + (right - left) // 2
            zeros = trailingZeroes(mid)
            if zeros == k:
                return 5
            elif zeros < k:
                left = mid + 1
            else:
                right = mid - 1
        return 0