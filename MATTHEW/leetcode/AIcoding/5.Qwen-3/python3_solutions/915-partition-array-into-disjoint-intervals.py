class Solution:
    def partitionDisjoint(self, nums: List[int]) -> int:
        max_so_far = nums[0]
        current_max = nums[0]
        result = 0
        for i in range(1, len(nums)):
            if nums[i] < max_so_far:
                result = i
            else:
                current_max = max(current_max, nums[i])
            max_so_far = max(max_so_far, nums[i])
        return result