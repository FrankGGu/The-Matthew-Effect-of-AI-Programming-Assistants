class Solution:
    def smallestString(self, s: str) -> str:
        s = list(s)
        n = len(s)
        for i in range(n):
            if s[i] != 'a':
                for j in range(i, n):
                    if s[j] == 'a':
                        break
                    s[j] = chr(ord(s[j]) - 1)
                return ''.join(s)
        s[-1] = 'z'
        return ''.join(s)