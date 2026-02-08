class Solution:
    def sumsOfSubsequences(self, nums: list[int], k: int) -> int:
        n = len(nums)
        MOD = 10**9 + 7

        nums.sort()

        # Precompute factorials and inverse factorials.
        # Max value for n_val in nCr_mod_p is n-1.
        # Max value for r_val in nCr_mod_p is k-1.
        # The largest factorial needed is for max(n, k).
        # Since n can be up to 10^5, precompute up to n.
        max_val_for_fact = n
        fact = [1] * (max_val_for_fact + 1)
        invFact = [1] * (max_val_for_fact + 1)

        for i in range(1, max_val_for_fact + 1):
            fact[i] = (fact[i-1] * i) % MOD

        invFact[max_val_for_fact] = pow(fact[max_val_for_fact], MOD - 2, MOD)
        for i in range(max_val_for_fact - 1, -1, -1):
            invFact[i] = (invFact[i+1] * (i+1)) % MOD

        def nCr_mod_p(n_val, r_val):
            if r_val < 0 or r_val > n_val:
                return 0
            if r_val == 0 or r_val == n_val:
                return 1

            num = fact[n_val]
            den = (invFact[r_val] * invFact[n_val - r_val]) % MOD
            return (num * den) % MOD

        # P_values[X] stores sum_{m=0}^{min(X, k-1)} C(X, m)
        # This is the number of ways to choose at most k-1 elements from X elements.
        P_values = [0] * n 

        if k == 0:
            return 0

        # current_C_row[j] will store C(X, j) for the current X.
        # We need C(X, j) for j from 0 up to k-1.
        # The length of current_C_row should be k.
        current_C_row = [0] * k 

        # Base case for X = 0: C(0,0) = 1.
        # P_values[0] = sum_{m=0}^{min(0, k-1)} C(0, m)
        # If k-1 >= 0 (i.e., k >= 1), P_values[0] = C(0,0) = 1.
        if k >= 1:
            current_C_row[0] = 1 # C(0,0)
            P_values[0] = 1

        # Iterate X from 1 to n-1 to compute P_values[X]
        for x in range(1, n):
            # Update current_C_row to represent C(x, j) from C(x-1, j)
            # C(x, j) = C(x-1, j) + C(x-1, j-1)
            # Iterate j downwards to use previous C(x-1, j) and C(x-1, j-1) values correctly.
            # The maximum j we need is min(x, k-1).
            # The loop range for j is [min(x, k-1), 1].
            for j in range(min(x, k - 1), 0, -1):
                current_C_row[j] = (current_C_row[j] + current_C_row[j-1]) % MOD
            # current_C_row[0] is C(x, 0), which is always 1. It remains 1 from the previous iteration or base case.

            # After updating current_C_row for X, calculate P_values[X]
            # P_values[X] = sum_{j=0}^{min(X, k-1)} C(X, j)
            current_P_sum = 0
            for j in range(min(x, k - 1) + 1):
                current_P_sum = (current_P_sum + current_C_row[j]) % MOD
            P_values[x] = current_P_sum

        total_ans = 0
        for i in range(n):
            # nums[i] as max: it is the maximum element. Other elements are chosen from nums[0...i-1].
            # There are `i` elements available. We need to choose `m` elements from them.
            # Total length of subsequence is 1 (for nums[i]) + m.
            # So 1 + m <= k => m <= k-1.
            # Number of ways to choose `m` elements from `i` such that `m <= k-1` is P(i, k-1).
            count_as_max = P_values[i]

            # nums[i] as min: it is the minimum element. Other elements are chosen from nums[i+1...n-1].
            # There are `n-1-i` elements available. We need to choose `m` elements from them.
            # Total length of subsequence is 1 (for nums[i]) + m.
            # So 1 + m <= k => m <= k-1.
            # Number of ways to choose `m` elements from `n-1-i` such that `m <= k-1` is P(n-1-i, k-1).
            count_as_min = P_values[n - 1 - i]

            # Each nums[i] contributes nums[i] * (count_as_max + count_as_min) to the total sum.
            total_ans = (total_ans + nums[i] * (count_as_max + count_as_min)) % MOD

        return total_ans