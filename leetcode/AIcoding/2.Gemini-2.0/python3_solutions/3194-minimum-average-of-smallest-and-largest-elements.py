class Solution:
    def minimumAverage(self, nums: list[int]) -> float:
        n = len(nums)
        nums.sort()
        ans = float('inf')
        for k in range(2, n + 1):
            curr_sum = 0
            for i in range(n - k + 1):
                curr_sum = nums[i] + nums[i + k - 1]
                ans = min(ans, curr_sum / 2)
        return ans