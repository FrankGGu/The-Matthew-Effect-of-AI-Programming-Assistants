class Solution:
    def findMaxValueOfEquation(self, points: List[List[int]], k: int) -> int:
        from collections import deque
        q = deque()
        max_val = float('-inf')
        for x, y in points:
            while q and x - q[0][1] > k:
                q.popleft()
            if q:
                max_val = max(max_val, x + y + q[0][0])
            while q and y - x >= q[-1][0]:
                q.pop()
            q.append((y - x, x))
        return max_val