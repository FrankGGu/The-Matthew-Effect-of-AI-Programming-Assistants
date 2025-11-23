class Solution:
    def maximizeActiveSection(self, nums: List[int], k: int) -> int:
        from collections import deque

        q = deque()
        max_active = 0
        for i in range(len(nums)):
            while q and nums[i] >= nums[q[-1]]:
                q.pop()
            q.append(i)
            while q[0] <= i - k:
                q.popleft()
            if i >= k - 1:
                max_active = max(max_active, nums[q[0]])
        return max_active