from collections import deque

class Solution:
    def constrainedSubsetSum(self, nums: List[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        max_deque = deque()

        for i in range(n):
            dp[i] = nums[i] + (max_deque[0] if max_deque else 0)
            while max_deque and dp[i] > max_deque[-1]:
                max_deque.pop()
            if dp[i] > 0:
                max_deque.append(dp[i])
            if i >= k and max_deque and max_deque[0] == dp[i - k]:
                max_deque.popleft()

        return max(dp)