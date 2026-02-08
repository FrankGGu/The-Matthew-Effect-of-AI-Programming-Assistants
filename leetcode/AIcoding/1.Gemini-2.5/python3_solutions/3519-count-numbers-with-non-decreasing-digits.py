import math

class Solution:
    def countNumbers(self, n: int) -> int:
        # The problem asks to count numbers X such that 0 <= X < 10^n
        # and X has non-decreasing digits.
        # This is equivalent to counting non-decreasing sequences of length n
        # using digits from 0 to 9.
        # For example, if n=2, we count sequences like 00, 01, ..., 09, 11, ..., 99.
        # Each such sequence corresponds to a unique non-decreasing number.
        # 00 -> 0
        # 01 -> 1
        # ...
        # 09 -> 9
        # 11 -> 11
        # ...
        # 99 -> 99
        #
        # This is a stars and bars problem. We are choosing n digits from 10 possible digits (0-9)
        # with replacement, and the order is fixed (non-decreasing).
        # The formula for this is C(r + k - 1, k) where r is the number of categories (10 digits)
        # and k is the number of items to choose (n digits).
        # So, C(10 + n - 1, n) = C(n + 9, n).
        #
        # We can also write C(N, K) as C(N, N-K).
        # So C(n + 9, n) = C(n + 9, (n + 9) - n) = C(n + 9, 9).
        # This is useful because 9 is a small constant, making calculations faster.

        N = n + 9
        K = n

        # To optimize calculation, use K = min(K, N - K)
        # In this specific problem, N - K will always be 9, so K will be min(n, 9).
        K = min(K, N - K)

        if K < 0:
            return 0
        if K == 0:
            return 1

        res = 1
        for i in range(K):
            res = res * (N - i) // (i + 1)
        return res