class Solution:
    def waysToSplitArray(self, nums: List[int]) -> int:
        n = len(nums)
        total_sum = sum(nums)
        count = 0
        current_sum = 0
        for i in range(n - 1):
            current_sum += nums[i]
            if current_sum >= total_sum - current_sum:
                count += 1
        return count