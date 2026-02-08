class Solution:
    def minimumCost(self, nums: list[int]) -> int:
        n = len(nums)

        remaining_elements = nums[1:]

        remaining_elements.sort()

        min_sum_of_two = remaining_elements[0] + remaining_elements[1]

        total_minimum_cost = nums[0] + min_sum_of_two

        return total_minimum_cost