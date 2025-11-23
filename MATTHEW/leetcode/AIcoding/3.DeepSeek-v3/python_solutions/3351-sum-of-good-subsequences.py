class Solution:
    def goodSubsequences(self, nums: List[int]) -> int:
        MOD = 10**9 + 7
        freq = {}
        for num in nums:
            freq[num] = freq.get(num, 0) + 1

        unique_nums = sorted(freq.keys())
        n = len(unique_nums)
        dp = [0] * (n + 1)
        dp[0] = 1

        for i in range(1, n + 1):
            num = unique_nums[i - 1]
            cnt = freq[num]
            dp[i] = dp[i - 1] * (1 + cnt) % MOD

        return (dp[n] - 1) % MOD