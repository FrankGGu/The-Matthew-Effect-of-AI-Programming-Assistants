class Solution:
    def findUnsortedSubarray(self, nums: list[int]) -> int:
        n = len(nums)
        if n <= 1:
            return 0

        max_so_far = nums[0]
        end = -1
        for i in range(1, n):
            if nums[i] < max_so_far:
                end = i
            else:
                max_so_far = nums[i]

        if end == -1:
            return 0

        min_so_far = nums[n - 1]
        start = -1
        for i in range(n - 2, -1, -1):
            if nums[i] > min_so_far:
                start = i
            else:
                min_so_far = nums[i]

        return end - start + 1