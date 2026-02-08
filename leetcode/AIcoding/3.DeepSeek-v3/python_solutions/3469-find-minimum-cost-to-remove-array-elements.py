import heapq

class Solution:
    def findMinimumCost(self, nums: List[int]) -> int:
        if len(nums) < 2:
            return 0

        heapq.heapify(nums)
        total_cost = 0

        while len(nums) > 1:
            first = heapq.heappop(nums)
            second = heapq.heappop(nums)
            cost = first + second
            total_cost += cost
            heapq.heappush(nums, cost)

        return total_cost