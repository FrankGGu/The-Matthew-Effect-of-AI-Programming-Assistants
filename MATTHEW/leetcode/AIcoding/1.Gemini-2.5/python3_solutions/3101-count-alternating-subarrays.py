class Solution:
    def countAlternatingSubarrays(self, nums: list[int]) -> int:
        total_alternating_subarrays = 0
        current_alternating_length = 0
        n = len(nums)

        for i in range(n):
            if i == 0 or nums[i] != nums[i-1]:
                current_alternating_length += 1
            else:
                current_alternating_length = 1

            total_alternating_subarrays += current_alternating_length

        return total_alternating_subarrays