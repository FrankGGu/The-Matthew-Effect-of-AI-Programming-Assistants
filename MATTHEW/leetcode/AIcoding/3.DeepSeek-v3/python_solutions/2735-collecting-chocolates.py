class Solution:
    def minCost(self, nums: List[int], x: int) -> int:
        n = len(nums)
        res = float('inf')
        min_costs = nums.copy()

        for shift in range(n):
            current_cost = sum(min_costs) + shift * x
            res = min(res, current_cost)

            for i in range(n):
                min_costs[i] = min(min_costs[i], nums[(i + shift + 1) % n])

        return res