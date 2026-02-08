class Solution:
    def smallestString(self, s: str) -> str:
        n = len(s)
        start = -1
        for i in range(n):
            if s[i] != 'a':
                start = i
                break

        if start == -1:
            return s[:-1] + 'z' if n > 0 else 'z'

        end = start
        while end < n and s[end] != 'a':
            end += 1

        res = list(s)
        for i in range(start, end):
            res[i] = chr(ord(s[i]) - 1)

        return "".join(res)