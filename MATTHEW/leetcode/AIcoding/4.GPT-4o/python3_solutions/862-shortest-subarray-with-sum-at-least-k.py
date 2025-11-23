from collections import deque

class Solution:
    def shortestSubarray(self, A: List[int], K: int) -> int:
        n = len(A)
        prefix_sum = [0] * (n + 1)

        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + A[i]

        ans = float('inf')
        dq = deque()

        for i in range(n + 1):
            while dq and prefix_sum[i] - prefix_sum[dq[0]] >= K:
                ans = min(ans, i - dq.popleft())
            while dq and prefix_sum[i] <= prefix_sum[dq[-1]]:
                dq.pop()
            dq.append(i)

        return ans if ans != float('inf') else -1