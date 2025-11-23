from collections import deque
from typing import List

class Solution:
    def findMaxValueOfEquation(self, nums: List[int], k: int) -> int:
        q = deque()
        max_val = float('-inf')
        for x, y in nums:
            while q and q[0][0] < x - k:
                q.popleft()
            if q:
                max_val = max(max_val, q[0][1] + y)
            while q and q[-1][1] <= y:
                q.pop()
            q.append((x, y))
        return max_val