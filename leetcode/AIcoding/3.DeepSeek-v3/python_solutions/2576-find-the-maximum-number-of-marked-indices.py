class Solution:
    def maxNumOfMarkedIndices(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        res = 0
        i, j = 0, n // 2
        while i < n // 2 and j < n:
            if 2 * nums[i] <= nums[j]:
                res += 2
                i += 1
                j += 1
            else:
                j += 1
        return res