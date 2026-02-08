class Solution:
    def squareFreeSubsets(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        primes = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29]
        n = len(primes)
        dp = [0] * (1 << n)
        dp[0] = 1

        for num in nums:
            if num == 1:
                dp[0] = (dp[0] * 2) % MOD
                continue
            mask = 0
            valid = True
            temp = num
            for i in range(n):
                p = primes[i]
                cnt = 0
                while temp % p == 0:
                    cnt += 1
                    temp = temp // p
                if cnt >= 2:
                    valid = False
                    break
                if cnt == 1:
                    mask |= (1 << i)
            if not valid:
                continue
            for m in range((1 << n) - 1, -1, -1):
                if (m & mask) == 0:
                    new_mask = m | mask
                    dp[new_mask] = (dp[new_mask] + dp[m]) % MOD
        total = (sum(dp) - 1) % MOD
        return total