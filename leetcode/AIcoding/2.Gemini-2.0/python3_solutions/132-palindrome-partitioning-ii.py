class Solution:
    def minCut(self, s: str) -> int:
        n = len(s)
        if n <= 1:
            return 0

        is_palindrome = [[False] * n for _ in range(n)]
        for i in range(n):
            is_palindrome[i][i] = True

        for i in range(n - 1):
            if s[i] == s[i+1]:
                is_palindrome[i][i+1] = True

        for length in range(3, n + 1):
            for i in range(n - length + 1):
                j = i + length - 1
                if s[i] == s[j] and is_palindrome[i+1][j-1]:
                    is_palindrome[i][j] = True

        cuts = [float('inf')] * n
        for i in range(n):
            if is_palindrome[0][i]:
                cuts[i] = 0
            else:
                for j in range(i):
                    if is_palindrome[j+1][i]:
                        cuts[i] = min(cuts[i], cuts[j] + 1)

        return cuts[n-1]