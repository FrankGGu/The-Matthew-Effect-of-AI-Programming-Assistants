import collections

class Solution:
    def maxResult(self, nums: list[int], k: int) -> int:
        n = len(nums)

        # dp[i] will store the maximum score to reach index i.
        # Initialize dp array.
        dp = [0] * n
        dp[0] = nums[0]

        # Deque stores (score, index) pairs.
        # It maintains scores in decreasing order.
        # The front of the deque (dq[0]) always holds the maximum score
        # within the current sliding window [i-k, i-1].
        dq = collections.deque()
        dq.append((dp[0], 0)) # Add the initial state (score, index)

        for i in range(1, n):
            # 1. Remove elements from the front of the deque whose indices are
            #    out of the current sliding window [i-k, i-1].
            #    An index `j` is out of window if `j < i - k`.
            while dq and dq[0][1] < i - k:
                dq.popleft()

            # 2. Calculate dp[i]: The maximum score to reach index i is nums[i]
            #    plus the maximum score from a reachable previous index.
            #    The maximum score from a reachable previous index is dq[0][0].
            dp[i] = nums[i] + dq[0][0]

            # 3. Remove elements from the back of the deque that are smaller than or
            #    equal to dp[i]. This maintains the decreasing order of scores.
            #    If a new score dp[i] is greater than or equal to an existing score dp[j]
            #    and j > i, then dp[j] is no longer useful as dp[i] provides a better
            #    or equal score from an earlier or same position.
            while dq and dq[-1][0] <= dp[i]:
                dq.pop()

            # 4. Add the current score and its index to the back of the deque.
            dq.append((dp[i], i))

        # The maximum score to reach the last index (n-1) is dp[n-1].
        return dp[n-1]