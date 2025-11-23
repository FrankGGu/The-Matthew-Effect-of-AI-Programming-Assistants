class Solution:
    def minOperations(self, nums: List[int]) -> int:
        left = right = -1
        for i in range(len(nums)):
            if nums[i] == 1:
                if left == -1:
                    left = i
                right = i

        if left == -1:
            return len(nums)

        return min(right + 1, len(nums) - left)