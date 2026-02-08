class Solution:
    def partitionDisjoint(self, nums: list[int]) -> int:
        left_max = nums[0]
        overall_max = nums[0]
        partition_index = 0

        for i in range(1, len(nums)):
            if nums[i] < left_max:
                partition_index = i
                left_max = overall_max
            else:
                overall_max = max(overall_max, nums[i])

        return partition_index + 1