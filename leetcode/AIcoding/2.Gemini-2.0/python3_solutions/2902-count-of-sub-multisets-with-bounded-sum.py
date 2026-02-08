class Solution:
    def countSubMultisets(self, nums: List[int], l: int, r: int) -> int:
        MOD = 10**9 + 7
        count = defaultdict(int)
        for num in nums:
            count[num] += 1

        dp = [0] * (r + 1)
        dp[0] = 1

        for num in sorted(count.keys()):
            c = count[num]
            if num == 0:
                continue

            for i in range(r, num - 1, -1):
                for j in range(1, min(c + 1, i // num + 1)):
                    dp[i] = (dp[i] + dp[i - j * num]) % MOD

        ans = 0
        zero_count = count[0]
        for i in range(l, r + 1):
            ans = (ans + dp[i]) % MOD

        ans = (ans * (zero_count + 1)) % MOD
        return ans