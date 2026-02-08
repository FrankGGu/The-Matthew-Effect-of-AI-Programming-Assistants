class Solution:
    def minimumDeletions(self, nums: List[int]) -> int:
        nums.sort()
        n = len(nums)
        deletions = 0
        for i in range(n // 2):
            if nums[i] < nums[n - 1 - i]:
                deletions += 1
        return deletions