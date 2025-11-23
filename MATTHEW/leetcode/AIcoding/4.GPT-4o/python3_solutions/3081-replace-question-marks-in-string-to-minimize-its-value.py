class Solution:
    def minValue(self, s: str) -> str:
        s = list(s)
        for i in range(len(s)):
            if s[i] == '?':
                if i == 0:
                    s[i] = '1'
                else:
                    s[i] = '0'
        return ''.join(s)