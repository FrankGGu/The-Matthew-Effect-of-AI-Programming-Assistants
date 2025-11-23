class Solution:
    def preimageSizeFZF(self, k: int) -> int:
        def trailingZeroes(n: int) -> int:
            count = 0
            while n >= 5:
                n //= 5
                count += n
            return count

        # Binary search for the smallest x such that trailingZeroes(x) >= k
        left = 0
        # A loose upper bound for x. Since trailingZeroes(x) is roughly x/4,
        # x is roughly 4k. 5k + 5 is a safe upper bound.
        # For k = 10^9, right = 5 * 10^9 + 5.
        right = 5 * k + 5 

        ans_x = right # This will store the smallest x found such that trailingZeroes(x) >= k

        while left <= right:
            mid = left + (right - left) // 2
            zeros = trailingZeroes(mid)

            if zeros >= k:
                ans_x = mid
                right = mid - 1
            else: # zeros < k
                left = mid + 1

        # After binary search, ans_x is the smallest non-negative integer
        # such that trailingZeroes(ans_x) >= k.

        # If trailingZeroes(ans_x) is exactly k, then k is a possible number of zeros.
        # In this case, there are exactly 5 integers (ans_x, ans_x+1, ans_x+2, ans_x+3, ans_x+4)
        # that yield k trailing zeros. This is because trailingZeroes(n) only increases
        # when n is a multiple of 5, and it increases by at least 1.
        # So, if trailingZeroes(ans_x) = k, then trailingZeroes(ans_x+1) = k, ..., trailingZeroes(ans_x+4) = k,
        # and trailingZeroes(ans_x+5) > k.
        if trailingZeroes(ans_x) == k:
            return 5
        else:
            # If trailingZeroes(ans_x) > k, it means k was skipped.
            # For example, trailingZeroes(24) = 4, trailingZeroes(25) = 6.
            # If k = 5, ans_x would be 25, and trailingZeroes(25) = 6 > 5.
            # This means no x exists such that trailingZeroes(x) = k.
            return 0