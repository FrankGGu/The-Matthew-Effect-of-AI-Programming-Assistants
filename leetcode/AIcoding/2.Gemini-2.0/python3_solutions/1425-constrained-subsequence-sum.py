import collections

class Solution:
    def constrainedSubsetSum(self, nums: list[int], k: int) -> int:
        n = len(nums)
        dp = [0] * n
        dp[0] = nums[0]
        max_sum = nums[0]

        deque = collections.deque([0])

        for i in range(1, n):
            while deque and deque[0] < i - k:
                deque.popleft()

            dp[i] = max(0, dp[deque[0]]) + nums[i]
            max_sum = max(max_sum, dp[i])

            while deque and dp[deque[-1]] <= dp[i]:
                deque.pop()

            deque.append(i)

        return max_sum