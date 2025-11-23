class Solution:
    def lexSmallestString(self, s: str) -> str:
        s = list(s)
        n = len(s)
        i = 0
        while i < n - 1:
            if s[i] > s[i + 1]:
                s[i], s[i + 1] = s[i + 1], s[i]
                i = max(0, i - 1)
            else:
                i += 1
        return ''.join(s)