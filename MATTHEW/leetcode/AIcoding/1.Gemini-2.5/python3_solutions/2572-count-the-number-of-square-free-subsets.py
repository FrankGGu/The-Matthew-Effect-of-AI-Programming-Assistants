import collections

class Solution:
    def squareFreeSubsets(self, nums: list[int]) -> int:
        MOD = 10**9 + 7

        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        prime_to_idx = {p: i for i, p in enumerate(primes)}

        # Precompute square-free status and masks for numbers from 1 to 30.
        # masks[i] will store the bitmask of prime factors for square-free 'i'.
        # If 'i' is not square-free, masks[i] will be -1.
        masks = [-1] * 31
        for i in range(1, 31):
            if i == 1:
                masks[i] = 0  # Mask for 1 is 0 (no prime factors)
                continue

            current_mask = 0
            is_square_free = True

            # Check for prime factors and square-freeness
            for p in primes:
                if i % p == 0:
                    # If 'i' is divisible by p*p, it's not square-free
                    if i % (p * p) == 0:
                        is_square_free = False
                        break
                    current_mask |= (1 << prime_to_idx[p])

            if is_square_free:
                masks[i] = current_mask

        # dp[mask] will store the number of square-free subsets whose product
        # has prime factors represented by 'mask'.
        dp = [0] * (1 << len(primes))
        dp[0] = 1  # Represents the empty set, whose product is 1 (square-free)

        count_ones = 0

        # Filter numbers: count 1s separately, and collect unique square-free numbers > 1.
        unique_sf_nums = set()
        for num in nums:
            if num == 1:
                count_ones += 1
            elif masks[num] != -1:  # If num is square-free and not 1
                unique_sf_nums.add(num)

        # Iterate through each unique square-free number (excluding 1)
        # and update the DP table.
        for num in unique_sf_nums:
            curr_mask = masks[num]

            # Iterate from largest mask down to 0. This ensures that when we update
            # dp[prev_mask | curr_mask], we are using dp[prev_mask] from the state
            # before 'num' was considered, preventing double-counting or incorrect updates.
            for prev_mask in range((1 << len(primes)) - 1, -1, -1):
                if dp[prev_mask] > 0:
                    # If the prime factors of 'num' do not overlap with 'prev_mask'
                    if (prev_mask & curr_mask) == 0:
                        dp[prev_mask | curr_mask] = (dp[prev_mask | curr_mask] + dp[prev_mask]) % MOD

        # Sum all counts in dp to get the total number of square-free subsets
        # formed by numbers greater than 1.
        total_subsets_without_ones = sum(dp) % MOD

        # Account for the '1's: each '1' can either be included or not included
        # in any square-free subset. If there are 'count_ones' occurrences of '1',
        # then for each subset formed by numbers > 1, there are 2^count_ones ways
        # to combine it with '1's.
        final_answer = (total_subsets_without_ones * pow(2, count_ones, MOD)) % MOD

        return final_answer