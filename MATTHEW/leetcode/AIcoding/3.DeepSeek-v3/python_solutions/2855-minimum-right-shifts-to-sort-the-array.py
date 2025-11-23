class Solution:
    def minimumRightShifts(self, nums: List[int]) -> int:
        n = len(nums)
        pivot = 0

        for i in range(1, n):
            if nums[i] < nums[i-1]:
                pivot = i
                break

        if pivot == 0:
            return 0

        if nums[-1] > nums[0]:
            return -1

        for i in range(pivot, n-1):
            if nums[i] > nums[i+1]:
                return -1

        return n - pivot