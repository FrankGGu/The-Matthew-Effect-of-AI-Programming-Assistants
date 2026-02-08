class Solution:
    def sumOfGoodSubsequences(self, nums: list[int]) -> int:
        MOD = 10**9 + 7

        # dp_even_cnt: count of subsequences with an even sum
        # dp_even_sum: sum of values of all subsequences with an even sum
        # dp_odd_cnt: count of subsequences with an odd sum
        # dp_odd_sum: sum of values of all subsequences with an odd sum
        dp_even_cnt = 0
        dp_even_sum = 0
        dp_odd_cnt = 0
        dp_odd_sum = 0

        for num in nums:
            # Store current states before updating to use them for calculations
            curr_even_cnt = dp_even_cnt
            curr_even_sum = dp_even_sum
            curr_odd_cnt = dp_odd_cnt
            curr_odd_sum = dp_odd_sum

            if num % 2 == 0:  # num is even
                # New even sum subsequences:
                # 1. Existing even sum subsequences (curr_even_cnt, curr_even_sum)
                # 2. Existing even sum subsequences + num
                #    - Count: curr_even_cnt
                #    - Sum: curr_even_sum + curr_even_cnt * num
                # 3. Subsequence [num]
                #    - Count: 1
                #    - Sum: num
                dp_even_cnt = (curr_even_cnt + curr_even_cnt + 1) % MOD
                dp_even_sum = (curr_even_sum + curr_even_sum + curr_even_cnt * num + num) % MOD

                # New odd sum subsequences:
                # 1. Existing odd sum subsequences (curr_odd_cnt, curr_odd_sum)
                # 2. Existing odd sum subsequences + num
                #    - Count: curr_odd_cnt
                #    - Sum: curr_odd_sum + curr_odd_cnt * num
                dp_odd_cnt = (curr_odd_cnt + curr_odd_cnt) % MOD
                dp_odd_sum = (curr_odd_sum + curr_odd_sum + curr_odd_cnt * num) % MOD
            else:  # num is odd
                # New even sum subsequences:
                # 1. Existing even sum subsequences (curr_even_cnt, curr_even_sum)
                # 2. Existing odd sum subsequences + num
                #    - Count: curr_odd_cnt
                #    - Sum: curr_odd_sum + curr_odd_cnt * num
                dp_even_cnt = (curr_even_cnt + curr_odd_cnt) % MOD
                dp_even_sum = (curr_even_sum + curr_odd_sum + curr_odd_cnt * num) % MOD

                # New odd sum subsequences:
                # 1. Existing odd sum subsequences (curr_odd_cnt, curr_odd_sum)
                # 2. Existing even sum subsequences + num
                #    - Count: curr_even_cnt
                #    - Sum: curr_even_sum + curr_even_cnt * num
                # 3. Subsequence [num]
                #    - Count: 1
                #    - Sum: num
                dp_odd_cnt = (curr_odd_cnt + curr_even_cnt + 1) % MOD
                dp_odd_sum = (curr_odd_sum + curr_even_sum + curr_even_cnt * num + num) % MOD

        # The problem asks for the sum of good subsequences.
        # Assuming "good" means the sum of elements in the subsequence is even.
        return dp_even_sum