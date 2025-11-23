class Solution:
    def sumImbalance(self, nums):
        n = len(nums)
        res = 0
        for i in range(n):
            max_val = nums[i]
            min_val = nums[i]
            balance = 0
            for j in range(i, n):
                if nums[j] > max_val:
                    max_val = nums[j]
                elif nums[j] < min_val:
                    min_val = nums[j]
                balance += (max_val - min_val) - (j - i)
                res += balance
        return res