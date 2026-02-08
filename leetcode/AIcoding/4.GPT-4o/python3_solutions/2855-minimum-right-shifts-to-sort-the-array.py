class Solution:
    def minimumRightShifts(self, nums: List[int]) -> int:
        n = len(nums)
        if n == 1:
            return 0

        sorted_nums = sorted(nums)

        for shift in range(n):
            if nums[shift:] + nums[:shift] == sorted_nums:
                return shift

        return -1