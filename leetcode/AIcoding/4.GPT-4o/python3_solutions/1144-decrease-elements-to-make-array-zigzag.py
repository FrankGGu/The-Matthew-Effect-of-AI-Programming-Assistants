class Solution:
    def movesToMakeZigzag(self, nums: List[int]) -> int:
        n = len(nums)
        even_cost = 0
        odd_cost = 0

        for i in range(n):
            left = nums[i - 1] if i > 0 else float('inf')
            right = nums[i + 1] if i < n - 1 else float('inf')
            current_cost = max(0, nums[i] - min(left, right) + 1)

            if i % 2 == 0:
                even_cost += current_cost
            else:
                odd_cost += current_cost

        return min(even_cost, odd_cost)