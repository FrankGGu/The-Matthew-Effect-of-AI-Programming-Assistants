class Solution:
    def minArraySum(self, nums: list[int]) -> int:
        nums.sort()

        current_sum = 0
        expected_next_unique = 1

        for num in nums:
            chosen_value = max(num, expected_next_unique)
            current_sum += chosen_value
            expected_next_unique = chosen_value + 1

        return current_sum