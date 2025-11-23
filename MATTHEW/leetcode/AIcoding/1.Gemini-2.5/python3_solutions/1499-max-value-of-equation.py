import collections

class Solution:
    def findMaxValueOfEquation(self, points: list[list[int]], k: int) -> int:
        max_val = float('-inf')
        dq = collections.deque() 

        for xj, yj in points:
            while dq and xj - dq[0][1] > k:
                dq.popleft()

            if dq:
                max_val = max(max_val, yj + xj + dq[0][0])

            while dq and dq[-1][0] <= yj - xj:
                dq.pop()
            dq.append((yj - xj, xj))

        return int(max_val)