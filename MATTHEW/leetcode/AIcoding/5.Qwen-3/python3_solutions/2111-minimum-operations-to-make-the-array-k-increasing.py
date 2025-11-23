class Solution:
    def minOperations(self, nums: List[int], k: int) -> int:
        def lis(nums):
            dp = []
            for num in nums:
                idx = bisect.bisect_left(dp, num)
                if idx == len(dp):
                    dp.append(num)
                else:
                    dp[idx] = num
            return len(dp)

        res = 0
        for i in range(k):
            sub = []
            for j in range(i, len(nums), k):
                sub.append(nums[j])
            res += len(sub) - lis(sub)
        return res