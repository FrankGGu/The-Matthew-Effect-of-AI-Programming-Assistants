class Solution:
    def minimumRightShifts(self, nums: List[int]) -> int:
        n = len(nums)
        sorted_nums = sorted(nums)
        for i in range(n):
            rotated_nums = nums[n - i:] + nums[:n - i]
            if rotated_nums == sorted_nums:
                return i
        return -1