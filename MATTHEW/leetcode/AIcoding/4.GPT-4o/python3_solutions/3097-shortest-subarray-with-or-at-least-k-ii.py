from collections import deque

class Solution:
    def shortestSubarray(self, A: List[int], K: int) -> int:
        n = len(A)
        prefix = [0] * (n + 1)
        for i in range(n):
            prefix[i + 1] = prefix[i] | A[i]

        result = float('inf')
        q = deque()

        for i in range(n + 1):
            while q and prefix[q[-1]] <= prefix[i]:
                q.pop()
            while q and (prefix[i] | prefix[q[0]]) < K:
                q.popleft()
            if q:
                result = min(result, i - q[0])
            q.append(i)

        return result if result != float('inf') else -1