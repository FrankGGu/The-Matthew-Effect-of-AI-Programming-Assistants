class Solution:
    def numberOfGoodSubsets(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        good_numbers = [1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30]
        count = [0] * 31
        for num in nums:
            count[num] += 1
        dp = [0] * (1 << len(primes))
        dp[0] = 1
        for num in good_numbers:
            mask = 0
            temp = num
            for i, prime in enumerate(primes):
                if temp % prime == 0:
                    mask |= (1 << i)
            if count[num] > 0:
                for i in range(1 << len(primes)):
                    if (i & mask) == 0:
                        dp[i | mask] = (dp[i | mask] + dp[i] * count[num]) % MOD
        ans = 0
        for i in range(1, 1 << len(primes)):
            ans = (ans + dp[i]) % MOD
        ans = (ans * pow(2, count[1], MOD)) % MOD
        return ans