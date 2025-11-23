from collections import deque
import bisect

class Solution:
    def boxDelivering(self, boxes: List[List[int]], portCost: int) -> int:
        n = len(boxes)
        dp = [0] * (n + 1)
        q = deque()
        q.append((0, 0))

        for i in range(1, n + 1):
            j = i - 1
            while j >= 0 and boxes[j][0] == boxes[i - 1][0]:
                j -= 1
            j += 1
            k = j
            while k < i:
                w = 0
                while k < i and w + boxes[k][1] <= 1000:
                    w += boxes[k][1]
                    k += 1
                if k > j:
                    cost = portCost
                    if q:
                        cost += dp[q[0][1]]
                    while q and q[-1][0] >= cost:
                        q.pop()
                    q.append((cost, i))
                j = k

        for i in range(1, n + 1):
            while q and q[0][1] < i:
                q.popleft()
            if q:
                dp[i] = dp[q[0][1]] + q[0][0]

        return dp[n]