class Solution:
    def maxMarkedIndices(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        i = 0
        j = (n + 1) // 2
        count = 0
        while j < n:
            if nums[j] >= 2 * nums[i]:
                count += 1
                i += 1
            j += 1
        return count * 2