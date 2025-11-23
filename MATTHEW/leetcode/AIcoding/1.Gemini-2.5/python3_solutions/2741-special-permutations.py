class Solution:
    def specialPermutations(self, nums: list[int]) -> int:
        n = len(nums)
        MOD = 10**9 + 7

        # dp[mask][last_idx] stores the number of special permutations
        # using elements represented by 'mask', where the last element
        # in the permutation is nums[last_idx].
        dp = [[0] * n for _ in range(1 << n)]

        # Base cases: permutations of length 1.
        # Each single element forms a valid special permutation.
        for i in range(n):
            dp[1 << i][i] = 1

        # Iterate through all possible masks (subsets of numbers used)
        # from smallest (length 1) to largest (full set).
        for mask in range(1, 1 << n):
            # Iterate through all possible indices for the last element in the permutation
            for last_idx in range(n):
                # If nums[last_idx] is part of the current mask AND
                # there are valid permutations ending with nums[last_idx] for this mask
                if (mask >> last_idx) & 1 and dp[mask][last_idx] > 0:
                    # Try to extend this permutation by adding a new element
                    for next_idx in range(n):
                        # If nums[next_idx] is not yet included in the current mask
                        if not ((mask >> next_idx) & 1):
                            # Check the divisibility condition
                            if nums[last_idx] % nums[next_idx] == 0 or \
                               nums[next_idx] % nums[last_idx] == 0:
                                # Form a new mask by including nums[next_idx]
                                new_mask = mask | (1 << next_idx)
                                # Add the count of permutations ending at last_idx
                                # to the new state ending at next_idx
                                dp[new_mask][next_idx] = (dp[new_mask][next_idx] + dp[mask][last_idx]) % MOD

        # After filling the DP table, sum up all permutations that use all elements.
        # The full mask represents all elements being used.
        total_special_permutations = 0
        full_mask = (1 << n) - 1
        for i in range(n):
            total_special_permutations = (total_special_permutations + dp[full_mask][i]) % MOD

        return total_special_permutations