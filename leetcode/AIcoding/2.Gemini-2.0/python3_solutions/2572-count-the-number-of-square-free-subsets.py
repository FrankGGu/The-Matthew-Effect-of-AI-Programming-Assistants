class Solution:
    def squareFreeSubsets(self, nums: list[int]) -> int:
        MOD = 10**9 + 7
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        good_numbers = [2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30]
        mask_map = {}
        for num in good_numbers:
            mask = 0
            temp = num
            for i, prime in enumerate(primes):
                if temp % prime == 0:
                    mask |= (1 << i)
            mask_map[num] = mask

        counts = {}
        for num in nums:
            if num in good_numbers:
                counts[num] = counts.get(num, 0) + 1

        dp = [0] * (1 << len(primes))
        dp[0] = 1

        for num in counts:
            mask = mask_map[num]
            for i in range(1 << len(primes)):
                if (i & mask) == 0:
                    dp[i | mask] = (dp[i | mask] + dp[i] * counts[num]) % MOD

        ans = -1 
        for x in dp:
            ans = (ans + x) % MOD

        count_one = nums.count(1)
        ans = (ans * pow(2, count_one, MOD)) % MOD

        return ans