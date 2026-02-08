class Solution:
    def minimumScore(self, nums: list[int]) -> int:
        nums.sort()
        n = len(nums)

        # Case 1: Change the two largest elements
        # The new max will be nums[n-3], min remains nums[0]
        score1 = nums[n - 3] - nums[0]

        # Case 2: Change the two smallest elements
        # The new min will be nums[2], max remains nums[n-1]
        score2 = nums[n - 1] - nums[2]

        # Case 3: Change one largest and one smallest element
        # The new max will be nums[n-2], new min will be nums[1]
        score3 = nums[n - 2] - nums[1]

        return min(score1, score2, score3)