class Solution:
    def countSpecialSubsequences(self, s: str) -> int:
        count = [0, 0, 0]
        for c in s:
            if c == 'a':
                count[0] += 1
            elif c == 'b':
                count[1] += count[0]
            elif c == 'c':
                count[2] += count[1]
        return count[2]