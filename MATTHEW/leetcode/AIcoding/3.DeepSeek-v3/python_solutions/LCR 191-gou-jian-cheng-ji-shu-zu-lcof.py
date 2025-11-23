class Solution:
    def calculateStatistics(self, nums: List[int]) -> List[int]:
        n = len(nums)
        res = [0] * n
        for i in range(n):
            count = 0
            for j in range(n):
                if i != j and nums[j] < nums[i]:
                    count += 1
            res[i] = count
        return res