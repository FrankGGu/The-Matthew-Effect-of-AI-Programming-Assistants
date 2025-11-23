class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        arr = sorted(zip(nums, cost))
        total = sum(cost)
        median_cost = 0
        res = 0
        target = 0

        for num, c in arr:
            median_cost += c
            if median_cost >= total / 2:
                target = num
                break

        for num, c in arr:
            res += abs(num - target) * c

        return res