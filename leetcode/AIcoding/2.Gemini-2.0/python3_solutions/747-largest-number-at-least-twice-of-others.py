class Solution:
    def dominantIndex(self, nums: list[int]) -> int:
        if not nums:
            return -1

        max_num = max(nums)
        max_index = nums.index(max_num)

        for i in range(len(nums)):
            if i != max_index and max_num < 2 * nums[i]:
                return -1

        return max_index