class Solution:
    def minIncrementOperations(self, nums: List[int]) -> int:
        from collections import deque

        n = len(nums)
        dp = [0] * n
        dq = deque()

        for i in range(n):
            if i < 2:
                dp[i] = nums[i]
            else:
                while dq and dq[0] < i - 2:
                    dq.popleft()
                dp[i] = nums[i] + dp[dq[0]] if dq else nums[i]
            while dq and dp[i] <= dp[dq[-1]]:
                dq.pop()
            dq.append(i)

        return dp[-1]