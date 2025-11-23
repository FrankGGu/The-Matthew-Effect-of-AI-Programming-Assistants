class Solution:
    def findTheArrayConcVal(self, nums: List[int]) -> int:
        n = len(nums)
        total = 0
        for i in range((n + 1) // 2):
            if i == n - i - 1:
                total += nums[i]
            else:
                total += int(str(nums[i]) + str(nums[n - i - 1]))
        return total