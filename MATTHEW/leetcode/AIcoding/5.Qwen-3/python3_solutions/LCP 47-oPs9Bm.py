class Solution:
    def check(self, n: int, k: int, a: List[int]) -> bool:
        from collections import deque
        q = deque()
        for i in range(n):
            while q and a[i] >= a[q[-1]]:
                q.pop()
            q.append(i)
            while q[0] <= i - k:
                q.popleft()
            if i >= k - 1:
                if a[q[0]] > 50:
                    return False
        return True