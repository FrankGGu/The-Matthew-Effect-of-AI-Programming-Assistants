class Solution:
    def countCells(self, s: str) -> int:
        rows = [0] * len(s)
        cols = [0] * len(s)

        for i in range(len(s)):
            for j in range(i + 1, len(s)):
                if s[i] == s[j]:
                    rows[i] += 1
                    cols[j] += 1

        total = 0
        for i in range(len(s)):
            total += rows[i] * cols[i]

        return total