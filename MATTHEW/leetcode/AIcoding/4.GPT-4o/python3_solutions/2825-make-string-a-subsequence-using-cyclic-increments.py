class Solution:
    def canMakeSubsequence(self, A: str, B: str) -> bool:
        n, m = len(A), len(B)
        if m > n:
            return False

        i, j = 0, 0
        while i < n and j < m:
            if A[i] == B[j]:
                j += 1
            i += 1

        if j < m:
            return False

        return all((ord(A[k]) - ord(B[k])) % 26 == 0 for k in range(m))