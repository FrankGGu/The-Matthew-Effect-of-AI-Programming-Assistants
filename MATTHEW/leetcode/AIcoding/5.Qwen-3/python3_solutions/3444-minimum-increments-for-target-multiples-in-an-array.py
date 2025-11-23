class Solution:
    def minIncrements(self, nums: List[int], k: int) -> int:
        from collections import deque

        nums.sort()
        res = 0
        q = deque()

        for num in nums:
            if q and q[0] < num:
                res += (num - q.popleft()) * k
            q.append(num)

        return res