class Solution:
    def partitionDisjoint(self, nums: List[int]) -> int:
        max_left = nums[0]
        partition_index = 0
        max_so_far = nums[0]

        for i in range(1, len(nums)):
            if nums[i] < max_left:
                partition_index = i
                max_left = max_so_far
            max_so_far = max(max_so_far, nums[i])

        return partition_index + 1