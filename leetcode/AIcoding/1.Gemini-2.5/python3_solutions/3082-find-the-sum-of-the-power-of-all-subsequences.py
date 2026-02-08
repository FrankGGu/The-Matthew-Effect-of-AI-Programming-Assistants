class Solution:
    def sumOfPower(self, nums: list[int]) -> int:
        MOD = 10**9 + 7
        n = len(nums)

        if n == 0:
            return 0

        total_sum_nums = sum(nums) % MOD

        # Each element `num` in `nums` will be part of 2^(n-1) subsequences.
        # For example, if nums = [a, b, c], n=3.
        # Subsequences containing 'a': [a], [a,b], [a,c], [a,b,c]. There are 2^(3-1) = 4 such subsequences.
        # The sum of powers for all subsequences is the sum of (element * count_of_subsequences_it_appears_in)
        # for each element.
        # This simplifies to (sum of all elements) * (2^(n-1)).

        power_of_2_n_minus_1 = pow(2, n - 1, MOD)

        result = (total_sum_nums * power_of_2_n_minus_1) % MOD

        return result