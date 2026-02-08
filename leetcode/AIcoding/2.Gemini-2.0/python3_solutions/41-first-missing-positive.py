class Solution:
    def firstMissingPositive(self, nums: List[int]) -> int:
        n = len(nums)
        contains_one = False
        for i in range(n):
            if nums[i] == 1:
                contains_one = True
            if nums[i] <= 0 or nums[i] > n:
                nums[i] = 1
        if not contains_one:
            return 1
        for i in range(n):
            index = abs(nums[i]) - 1
            if nums[index] > 0:
                nums[index] = -nums[index]
        for i in range(n):
            if nums[i] > 0:
                return i + 1
        return n + 1