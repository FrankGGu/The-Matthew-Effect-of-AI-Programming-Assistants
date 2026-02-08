class Solution:
    def largestDivisibleSubset(self, nums: List[int]) -> List[int]:
        nums.sort()
        n = len(nums)
        dp = [1] * n
        pre = [-1] * n
        max_index = 0
        for i in range(n):
            for j in range(i):
                if nums[i] % nums[j] == 0:
                    if dp[i] < dp[j] + 1:
                        dp[i] = dp[j] + 1
                        pre[i] = j
            if dp[i] > dp[max_index]:
                max_index = i
        res = []
        while max_index != -1:
            res.append(nums[max_index])
            max_index = pre[max_index]
        return res