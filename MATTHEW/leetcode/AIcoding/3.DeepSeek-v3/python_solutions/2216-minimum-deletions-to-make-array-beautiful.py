class Solution:
    def minDeletion(self, nums: List[int]) -> int:
        n = len(nums)
        deletions = 0
        i = 0
        while i < n:
            if (i - deletions) % 2 == 0 and i + 1 < n and nums[i] == nums[i + 1]:
                deletions += 1
                i += 1
            else:
                i += 1
        if (n - deletions) % 2 != 0:
            deletions += 1
        return deletions