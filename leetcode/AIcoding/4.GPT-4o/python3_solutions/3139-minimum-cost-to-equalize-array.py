class Solution:
    def minCost(self, nums: List[int], cost: List[int]) -> int:
        def total_cost(target):
            return sum(abs(num - target) * c for num, c in zip(nums, cost))

        left, right = min(nums), max(nums)
        while left < right:
            mid = (left + right) // 2
            if total_cost(mid) > total_cost(mid + 1):
                left = mid + 1
            else:
                right = mid
        return total_cost(left)