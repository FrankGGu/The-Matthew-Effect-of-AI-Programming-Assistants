import collections

class Solution:
    def maxResult(self, nums: list[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        dp[0] = nums[0]

        q = collections.deque()
        q.append(0)

        for i in range(1, n):
            while q and q[0] < i - k:
                q.popleft()

            dp[i] = nums[i] + dp[q[0]]

            while q and dp[q[-1]] <= dp[i]:
                q.pop()

            q.append(i)

        return dp[n-1]