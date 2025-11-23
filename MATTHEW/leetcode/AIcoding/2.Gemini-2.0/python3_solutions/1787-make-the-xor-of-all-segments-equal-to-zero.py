class Solution:
    def minChanges(self, nums: List[int], k: int) -> int:
        n = len(nums)
        max_xor = 1024
        freq = [{} for _ in range(k)]
        for i in range(n):
            if nums[i] not in freq[i % k]:
                freq[i % k][nums[i]] = 0
            freq[i % k][nums[i]] += 1

        dp = [float('inf')] * max_xor
        dp[0] = 0

        for i in range(k):
            total_count = n // k + (1 if i < n % k else 0)
            min_val = min(dp)
            new_dp = [min_val + total_count] * max_xor

            for xor_val, count in freq[i].items():
                for prev_xor in range(max_xor):
                    new_dp[prev_xor ^ xor_val] = min(new_dp[prev_xor ^ xor_val], dp[prev_xor] + total_count - count)

            dp = new_dp

        return dp[0]