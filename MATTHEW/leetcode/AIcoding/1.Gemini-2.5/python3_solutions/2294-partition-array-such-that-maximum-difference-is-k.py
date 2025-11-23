class Solution:
    def partitionArray(self, nums: list[int], k: int) -> int:
        nums.sort()

        count = 1
        current_min = nums[0]

        for i in range(1, len(nums)):
            if nums[i] - current_min > k:
                count += 1
                current_min = nums[i]

        return count