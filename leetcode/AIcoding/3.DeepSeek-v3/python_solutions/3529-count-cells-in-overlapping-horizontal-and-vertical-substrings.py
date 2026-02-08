class Solution:
    def countCells(self, s: str) -> int:
        n = len(s)
        horizontal = [False] * n
        vertical = [False] * n

        # Check horizontal substrings
        for i in range(n - 2):
            if s[i] == s[i+1] == s[i+2]:
                horizontal[i] = True
                horizontal[i+1] = True
                horizontal[i+2] = True

        # Check vertical substrings
        for i in range(n - 2):
            if s[i] != s[i+1] and s[i] == s[i+2]:
                vertical[i] = True
                vertical[i+1] = True
                vertical[i+2] = True

        count = 0
        for i in range(n):
            if horizontal[i] and vertical[i]:
                count += 1

        return count