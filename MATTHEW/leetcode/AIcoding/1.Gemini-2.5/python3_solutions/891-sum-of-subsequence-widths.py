class Solution:
    def sumSubseqWidths(self, nums: list[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        nums.sort()

        total_sum = 0

        # Precompute powers of 2
        powers_of_2 = [1] * n
        for i in range(1, n):
            powers_of_2[i] = (powers_of_2[i-1] * 2) % MOD

        for i in range(n):
            # Contribution of nums[i] as a maximum element
            # There are `i` elements before nums[i]. Each can be chosen or not (2^i ways).
            # nums[i] itself is included.
            max_contribution = (nums[i] * powers_of_2[i]) % MOD

            # Contribution of nums[i] as a minimum element
            # There are `n - 1 - i` elements after nums[i]. Each can be chosen or not (2^(n-1-i) ways).
            # nums[i] itself is included.
            min_contribution = (nums[i] * powers_of_2[n - 1 - i]) % MOD

            # Add to total sum, ensuring result stays within modulo range
            total_sum = (total_sum + max_contribution - min_contribution + MOD) % MOD

        return total_sum