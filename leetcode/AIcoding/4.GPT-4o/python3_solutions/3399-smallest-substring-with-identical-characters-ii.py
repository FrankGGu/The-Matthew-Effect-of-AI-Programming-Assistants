class Solution:
    def smallestSubstring(self, s: str) -> str:
        n = len(s)
        min_len = float('inf')
        min_substr = ""
        last_seen = {}

        l = 0
        for r in range(n):
            last_seen[s[r]] = r
            while len(last_seen) == len(set(s)):
                if r - l + 1 < min_len:
                    min_len = r - l + 1
                    min_substr = s[l:r + 1]
                last_seen[s[l]] -= 1
                if last_seen[s[l]] == 0:
                    del last_seen[s[l]]
                l += 1

        return min_substr