class Solution:
    def longestNiceSubstring(self, s: str) -> str:
        def is_nice(sub):
            return all(c.lower() in sub and c.upper() in sub for c in set(sub))

        max_len = 0
        start = 0
        for i in range(len(s)):
            for j in range(i + 1, len(s) + 1):
                if is_nice(s[i:j]) and j - i > max_len:
                    max_len = j - i
                    start = i
        return s[start:start + max_len]