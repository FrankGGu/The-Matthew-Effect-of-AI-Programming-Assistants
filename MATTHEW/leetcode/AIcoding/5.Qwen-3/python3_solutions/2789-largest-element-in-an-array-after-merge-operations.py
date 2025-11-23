class Solution:
    def maxAfterMerge(self, nums: List[int]) -> int:
        from collections import deque

        q = deque(nums)
        while len(q) > 1:
            a = q.popleft()
            b = q.popleft()
            q.append(a + b)
        return q[0]