class Solution:
    def findUnsortedSubarray(self, nums: List[int]) -> int:
        n = len(nums)
        l, r = -1, -1
        max_val = float('-inf')
        min_val = float('inf')

        for i in range(n):
            if nums[i] < max_val:
                r = i
            else:
                max_val = nums[i]

        for i in range(n - 1, -1, -1):
            if nums[i] > min_val:
                l = i
            else:
                min_val = nums[i]

        if l == -1:
            return 0
        else:
            return r - l + 1