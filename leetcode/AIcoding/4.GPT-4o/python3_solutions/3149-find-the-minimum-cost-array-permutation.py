class Solution:
    def findMinCost(self, nums: List[int], cost: List[int]) -> int:
        def total_cost(x):
            return sum(c * abs(num - x) for num, c in zip(nums, cost))

        left, right = min(nums), max(nums)
        while left < right:
            mid = (left + right) // 2
            if total_cost(mid) < total_cost(mid + 1):
                right = mid
            else:
                left = mid + 1
        return total_cost(left)