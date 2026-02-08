class Solution:
    def minCost(self, nums: List[int], cost: int) -> int:
        n = len(nums)
        ans = float('inf')

        for k in range(n):
            curr_cost = 0
            for i in range(n):
                curr_cost += abs(nums[i] - nums[k]) * cost
            ans = min(ans, curr_cost)

        return ans