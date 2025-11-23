class Solution:
    def minInteger(self, A: str) -> int:
        from collections import Counter

        count = Counter(A)
        n = len(A)
        for i in range(n):
            if A[i] == '0':
                continue
            if count[A[i]] > 1:
                return int(A[:i] + A[i+1:] + A[i])
            count[A[i]] -= 1
        return int(A)