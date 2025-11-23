class Solution:
    def distributeCandies(self, n: int, limit: int) -> int:

        def combinations2(N: int) -> int:
            if N < 2:
                return 0
            return N * (N - 1) // 2

        # Total ways to distribute n candies among 3 children without upper limit (c_i >= 0)
        # This is C(n + 3 - 1, 3 - 1) = C(n + 2, 2)
        ans = combinations2(n + 2)

        # Subtract cases where at least one child exceeds the limit
        # Use Principle of Inclusion-Exclusion (PIE)

        # Case 1: At least one child gets > limit candies (c_i >= limit + 1)
        # Choose 1 child: C(3, 1) ways.
        # Let c1' = c1 - (limit + 1). Then c1' >= 0.
        # (c1' + limit + 1) + c2 + c3 = n
        # c1' + c2 + c3 = n - (limit + 1)
        # Number of solutions = C(n - (limit + 1) + 2, 2) = C(n - limit + 1, 2)
        ans -= 3 * combinations2(n - limit + 1)

        # Case 2: At least two children get > limit candies (c_i, c_j >= limit + 1)
        # Choose 2 children: C(3, 2) ways.
        # Let c1' = c1 - (limit + 1), c2' = c2 - (limit + 1).
        # (c1' + limit + 1) + (c2' + limit + 1) + c3 = n
        # c1' + c2' + c3 = n - 2 * (limit + 1)
        # Number of solutions = C(n - 2 * (limit + 1) + 2, 2) = C(n - 2 * limit, 2)
        ans += 3 * combinations2(n - 2 * limit)

        # Case 3: All three children get > limit candies (c_1, c_2, c_3 >= limit + 1)
        # Choose 3 children: C(3, 3) ways.
        # Let c1' = c1 - (limit + 1), c2' = c2 - (limit + 1), c3' = c3 - (limit + 1).
        # (c1' + limit + 1) + (c2' + limit + 1) + (c3' + limit + 1) = n
        # c1' + c2' + c3' = n - 3 * (limit + 1)
        # Number of solutions = C(n - 3 * (limit + 1) + 2, 2) = C(n - 3 * limit - 1, 2)
        ans -= 1 * combinations2(n - 3 * limit - 1)

        return ans