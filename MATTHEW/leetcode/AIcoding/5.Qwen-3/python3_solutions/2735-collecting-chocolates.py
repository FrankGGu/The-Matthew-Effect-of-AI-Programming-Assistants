class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        pairs = sorted(zip(nums, cost))
        total_cost = 0
        for i in range(1, len(pairs)):
            total_cost += abs(pairs[i][0] - pairs[0][0]) * pairs[i][1]
        min_total = total_cost
        for i in range(1, len(pairs)):
            diff = pairs[i][0] - pairs[i-1][0]
            total_cost -= diff * sum(cost[:i])
            total_cost += diff * sum(cost[i:])
            min_total = min(min_total, total_cost)
        return min_total