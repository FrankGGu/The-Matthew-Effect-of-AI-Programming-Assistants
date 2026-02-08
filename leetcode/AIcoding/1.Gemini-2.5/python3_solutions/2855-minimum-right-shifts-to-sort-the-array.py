class Solution:
    def minimumRightShifts(self, nums: list[int]) -> int:
        n = len(nums)

        if n <= 1:
            return 0

        descent_count = 0
        descent_idx = -1 

        for i in range(n - 1):
            if nums[i] > nums[i+1]:
                descent_count += 1
                descent_idx = i

        if descent_count == 0:
            return 0

        if descent_count == 1:
            if nums[n-1] < nums[0]:
                return n - 1 - descent_idx
            else:
                return -1

        return -1