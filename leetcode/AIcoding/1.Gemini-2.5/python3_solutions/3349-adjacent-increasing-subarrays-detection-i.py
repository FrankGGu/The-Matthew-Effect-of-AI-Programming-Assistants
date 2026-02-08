class Solution:
    def canBeSplit(self, nums: list[int]) -> bool:
        n = len(nums)
        if n < 2:
            return False

        prefix_is_increasing = [True] * n
        for i in range(1, n):
            prefix_is_increasing[i] = prefix_is_increasing[i-1] and (nums[i-1] < nums[i])

        suffix_is_increasing = [True] * n
        for i in range(n - 2, -1, -1):
            suffix_is_increasing[i] = suffix_is_increasing[i+1] and (nums[i] < nums[i+1])

        for i in range(n - 1):
            if prefix_is_increasing[i] and suffix_is_increasing[i+1]:
                return True

        return False