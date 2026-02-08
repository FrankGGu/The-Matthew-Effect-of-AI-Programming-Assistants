class Solution:
    def countElements(self, nums: list[int]) -> int:
        if len(nums) < 3:
            return 0

        min_val = nums[0]
        max_val = nums[0]

        for num in nums:
            if num < min_val:
                min_val = num
            if num > max_val:
                max_val = num

        count = 0
        if min_val == max_val: # All elements are the same, no element can satisfy the condition
            return 0

        for num in nums:
            if min_val < num < max_val:
                count += 1

        return count