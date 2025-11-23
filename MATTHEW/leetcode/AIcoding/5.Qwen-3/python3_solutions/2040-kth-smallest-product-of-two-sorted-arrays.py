class Solution:
    def kthSmallestProduct(self, A: List[int], B: List[int], k: int) -> int:
        from bisect import bisect_left, bisect_right

        def count_less_equal(x):
            cnt = 0
            j = len(B) - 1
            for a in A:
                if a > 0:
                    idx = bisect_left(B, x // a + (1 if x % a < 0 else 0))
                    cnt += idx
                elif a < 0:
                    idx = bisect_right(B, x // a - (1 if x % a > 0 else 0))
                    cnt += len(B) - idx
                else:
                    if x >= 0:
                        cnt += len(B)
            return cnt

        left = -10**5
        right = 10**5
        while left < right:
            mid = (left + right) // 2
            if count_less_equal(mid) < k:
                left = mid + 1
            else:
                right = mid
        return left