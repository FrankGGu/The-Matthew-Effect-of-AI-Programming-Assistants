class Solution:
    def rob(self, nums: List[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        def rob_line(houses):
            prev, curr = 0, 0
            for amount in houses:
                prev, curr = curr, max(curr, prev + amount)
            return curr

        return max(rob_line(nums[:-1]), rob_line(nums[1:]))