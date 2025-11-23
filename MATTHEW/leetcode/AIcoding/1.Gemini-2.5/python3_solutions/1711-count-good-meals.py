from collections import defaultdict

class Solution:
    def countGoodMeals(self, deliciousness: list[int]) -> int:
        MOD = 10**9 + 7
        counts = defaultdict(int)
        ans = 0

        # The maximum possible price is 2^20.
        # The maximum possible sum of two prices is 2 * 2^20 = 2^21.
        # So, we need to consider powers of two from 2^0 up to 2^21.
        powers_of_two = [1 << i for i in range(22)]

        for p in deliciousness:
            for target_sum in powers_of_two:
                complement = target_sum - p
                if complement in counts:
                    ans = (ans + counts[complement]) % MOD
            counts[p] += 1

        return ans