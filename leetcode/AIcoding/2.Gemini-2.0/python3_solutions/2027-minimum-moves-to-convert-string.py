class Solution:
    def minimumMoves(self, s: str) -> int:
        n = len(s)
        ans = 0
        i = 0
        while i < n:
            if s[i] == 'X':
                ans += 1
                i += 3
            else:
                i += 1
        return ans