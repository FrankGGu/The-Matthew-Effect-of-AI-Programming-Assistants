class Solution:
    def sumOfPower(self, nums: list[int], k: int) -> int:
        n = len(nums)
        ans = 0
        mod = 10**9 + 7
        for i in range(n - k + 1):
            sub_array = nums[i:i+k]
            min_val = min(sub_array)
            max_val = max(sub_array)
            sum_val = sum(sub_array)
            ans = (ans + min_val * max_val * sum_val) % mod
        return ans