class Solution:
    def rob(self, nums: List[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        def rob_range(start, end):
            prev_max = 0
            curr_max = 0
            for i in range(start, end + 1):
                temp = curr_max
                curr_max = max(prev_max + nums[i], curr_max)
                prev_max = temp
            return curr_max

        return max(rob_range(0, len(nums) - 2), rob_range(1, len(nums) - 1))