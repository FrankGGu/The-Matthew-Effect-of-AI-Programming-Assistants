class Solution:
    def lastSubstring(self, s: str) -> str:
        max_char = max(s)
        max_indices = [i for i, c in enumerate(s) if c == max_char]
        res = ""
        for i in max_indices:
            substring = s[i:]
            if substring > res:
                res = substring
        return res