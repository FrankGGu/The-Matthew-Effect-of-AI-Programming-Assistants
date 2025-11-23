class Solution:
    def minDeletion(self, nums: List[int]) -> int:
        n = len(nums)
        deletions = 0
        i = 0
        while i < n - deletions - 1:
            if (i % 2 == 0) and (nums[i] == nums[i + 1]):
                nums.pop(i)
                deletions += 1
            else:
                i += 1

        if (n - deletions) % 2 != 0:
            deletions += 1

        return deletions