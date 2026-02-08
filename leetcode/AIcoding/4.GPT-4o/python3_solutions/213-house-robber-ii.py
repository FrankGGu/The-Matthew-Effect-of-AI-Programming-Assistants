class Solution:
    def rob(self, nums: List[int]) -> int:
        if not nums:
            return 0
        if len(nums) == 1:
            return nums[0]

        def rob_linear(houses):
            prev, curr = 0, 0
            for house in houses:
                prev, curr = curr, max(prev + house, curr)
            return curr

        return max(rob_linear(nums[:-1]), rob_linear(nums[1:]))