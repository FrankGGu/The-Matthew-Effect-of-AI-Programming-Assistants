class Solution:
    def maximumDifference(self, nums: List[int]) -> int:
        max_diff = -1
        min_value = nums[0]

        for num in nums[1:]:
            if num > min_value:
                max_diff = max(max_diff, num - min_value)
            min_value = min(min_value, num)

        return max_diff