class Solution:
    def preimageSizeFZF(self, K: int) -> int:
        def zeros(n):
            count = 0
            while n > 0:
                n //= 5
                count += n
            return count

        left, right = 0, 5 * (K + 1)
        while left < right:
            mid = (left + right) // 2
            if zeros(mid) < K:
                left = mid + 1
            else:
                right = mid
        return 5 if zeros(left) == K else 0