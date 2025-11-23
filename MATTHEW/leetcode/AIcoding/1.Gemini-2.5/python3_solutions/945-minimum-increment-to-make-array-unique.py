class Solution:
    def minIncrementForUnique(self, nums: list[int]) -> int:
        nums.sort()

        increments = 0
        if not nums:
            return 0

        previous_unique_val = nums[0] 

        for i in range(1, len(nums)):
            current_num = nums[i]

            if current_num <= previous_unique_val:
                needed_val = previous_unique_val + 1
                increments += (needed_val - current_num)
                previous_unique_val = needed_val
            else:
                previous_unique_val = current_num

        return increments