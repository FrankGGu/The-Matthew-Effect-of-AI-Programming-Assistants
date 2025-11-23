import collections

class Solution:
    def numberOfGoodSubsets(self, nums: list[int]) -> int:
        MOD = 10**9 + 7

        # Primes up to 30
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]

        # Map prime to its bit index
        prime_to_idx = {p: i for i, p in enumerate(primes)}

        # Filter square-free numbers from 2 to 30 and calculate their prime masks
        # good_nums_info stores (number, prime_mask) pairs
        good_nums_info = [] 
        for num in range(2, 31):
            temp_num = num
            current_mask = 0
            is_square_free = True
            for p_idx, p in enumerate(primes):
                if temp_num % p == 0:
                    current_mask |= (1 << p_idx)
                    temp_num //= p
                    if temp_num % p == 0:  # Check for p^2 factor, indicating not square-free
                        is_square_free = False
                        break

            # If the number is square-free and all its prime factors are within our 'primes' list
            # (temp_num == 1 ensures all factors were accounted for by primes list)
            if is_square_free and temp_num == 1:
                good_nums_info.append((num, current_mask))

        # Count frequencies of numbers in the input `nums`
        counts = collections.Counter(nums)

        # dp[mask] will store the number of good subsets whose product of elements
        # has exactly the prime factors represented by 'mask'.
        # The size of dp array is 2^10 because there are 10 primes.
        dp = [0] * (1 << len(primes))
        dp[0] = 1 # Represents the empty set, which has a product of 1 (square-free, no prime factors)

        # Iterate through each square-free number (val) that is present in the input `nums`
        for val, mask_val in good_nums_info:
            if counts[val] == 0:
                continue # Skip if this number is not in the input

            # Iterate through masks in decreasing order to avoid using 'val' multiple times
            # in the same 'dp' calculation for a given 'val'.
            for prev_mask in range((1 << len(primes)) - 1, -1, -1):
                # If dp[prev_mask] is 0, no subsets exist for this mask, so skip
                if dp[prev_mask] == 0:
                    continue

                # If 'val' introduces no duplicate prime factors to 'prev_mask'
                # (i.e., their prime factor masks have no common bits set)
                if (prev_mask & mask_val) == 0:
                    # We can form new good subsets by adding 'val' to existing subsets
                    # that resulted in 'prev_mask'.
                    # The count is multiplied by counts[val] because we can choose 'val'
                    # from its available occurrences.
                    dp[prev_mask | mask_val] = (dp[prev_mask | mask_val] + dp[prev_mask] * counts[val]) % MOD

        # Calculate the total number of good subsets formed by numbers greater than 1.
        # We sum all dp[mask] where mask > 0. dp[0] represents the empty set, which is not a good subset.
        ans_no_one = (sum(dp) - dp[0]) % MOD

        # Account for the number '1'.
        # If '1' is present in `nums`, it can be included any number of times (up to its frequency)
        # in any good subset formed by numbers > 1 without changing the product or its square-free property.
        # If there are `k` occurrences of '1', there are `2^k` ways to choose '1's (including choosing none).
        count_of_ones = counts.get(1, 0)
        power_of_two_for_ones = pow(2, count_of_ones, MOD)

        # The final result is the product of good subsets from numbers > 1 and the ways to include '1's.
        result = (ans_no_one * power_of_two_for_ones) % MOD

        return result