class Solution:
    def maxNumOfMarkedIndices(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        marked = 0

        for i in range(n // 2):
            if nums[i] * 2 <= nums[n - 1 - i]:
                marked += 2

        if n % 2 == 1:
            marked += 1

        return marked