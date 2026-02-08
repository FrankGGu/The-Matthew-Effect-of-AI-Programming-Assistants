class Solution:
    def maximumProduct(self, nums: List[int], k: int) -> int:
        MOD = 10**9 + 7
        n = len(nums)
        dp = {}

        def dfs(index, current_sum, current_product):
            if index == n:
                return current_product if current_sum == k else 0
            key = (index, current_sum)
            if key in dp:
                return dp[key]
            # Option 1: skip the current number
            res = dfs(index + 1, current_sum, current_product)
            # Option 2: take the current number with alternating sign
            new_sum = current_sum + nums[index] if index % 2 == 0 else current_sum - nums[index]
            new_product = (current_product * nums[index]) % MOD
            res = max(res, dfs(index + 1, new_sum, new_product))
            dp[key] = res % MOD
            return dp[key]

        return dfs(0, 0, 1)