class Solution:
    def rob(self, nums: List[int]) -> int:
        def rob_range(start, end):
            prev, curr = 0, 0
            for i in range(start, end + 1):
                prev, curr = curr, max(curr, prev + nums[i])
            return curr

        if len(nums) == 1:
            return nums[0]
        return max(rob_range(0, len(nums) - 2), rob_range(1, len(nums) - 1))