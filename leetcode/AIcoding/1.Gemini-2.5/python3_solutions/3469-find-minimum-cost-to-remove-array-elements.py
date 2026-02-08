class Solution:
    def minCostToRemoveArrayElements(self, nums: list[int]) -> int:
        nums.sort(reverse=True)

        total_cost = 0
        for i in range(len(nums)):
            total_cost += nums[i] * i

        return total_cost