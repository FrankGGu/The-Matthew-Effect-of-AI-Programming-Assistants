import collections

class Solution:
    def findGCDSubsequences(self, nums: list[int], k: int) -> int:
        # Step 1: Filter numbers that are multiples of k and divide by k.
        # These are the numbers x' for which we want gcd(x'_1, ..., x'_m) = 1.
        filtered_divided_nums = []
        for x in nums:
            if x % k == 0:
                filtered_divided_nums.append(x // k)

        # If no numbers are multiples of k, no subsequence can have GCD equal to k.
        if not filtered_divided_nums:
            return 0

        # Step 2: Count occurrences of each unique value in filtered_divided_nums.
        # Also, find the maximum value to determine the size of the dp array.
        max_val = 0
        counts = collections.Counter()
        for x_prime in filtered_divided_nums:
            counts[x_prime] += 1
            max_val = max(max_val, x_prime)

        # Step 3: Initialize dp array.
        # dp[g] will store the number of subsequences whose GCD is exactly g.
        # The array size is max_val + 1 to accommodate values from 1 to max_val.
        dp = [0] * (max_val + 1)

        # Step 4: Iterate from max_val down to 1.
        # For each g, calculate the number of subsequences whose elements are all multiples of g.
        # Then, subtract the counts of subsequences whose GCD is a multiple of g (2g, 3g, etc.).
        for g in range(max_val, 0, -1):
            num_multiples_of_g = 0
            # Count total occurrences of numbers in filtered_divided_nums that are multiples of g.
            # This is done by summing counts[m] for all m that are multiples of g.
            for m in range(g, max_val + 1, g):
                num_multiples_of_g += counts[m]

            # If there are no numbers that are multiples of g, no subsequences can have GCD g or a multiple of g.
            if num_multiples_of_g == 0:
                continue

            # Calculate the total number of non-empty subsequences that can be formed
            # using only elements that are multiples of g.
            # The GCD of any such subsequence will necessarily be a multiple of g.
            total_subsequences_with_gcd_multiple_of_g = (1 << num_multiples_of_g) - 1

            # Subtract subsequences whose GCD is 2g, 3g, ..., etc.
            # These values (dp[2g], dp[3g], ...) have already been computed
            # because we are iterating g downwards.
            for m_mult in range(2 * g, max_val + 1, g):
                total_subsequences_with_gcd_multiple_of_g -= dp[m_mult]

            # The remaining count is the number of subsequences whose GCD is exactly g.
            dp[g] = total_subsequences_with_gcd_multiple_of_g

        # The answer is the number of subsequences whose GCD is exactly 1 (for the x' values).
        return dp[1]