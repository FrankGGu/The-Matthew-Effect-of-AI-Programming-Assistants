class Solution:
    def rob(self, nums: List[int]) -> int:
        if len(nums) == 1:
            return nums[0]
        if len(nums) == 2:
            return max(nums[0], nums[1])

        def helper(sub_nums):
            prev = curr = 0
            for num in sub_nums:
                temp = curr
                curr = max(curr, prev + num)
                prev = temp
            return curr

        return max(helper(nums[1:]), helper(nums[:-1]))