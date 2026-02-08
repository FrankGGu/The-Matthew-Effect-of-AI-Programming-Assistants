class Solution:
    def robotWithString(self, s: str) -> str:
        from collections import deque

        t = []
        res = []
        min_suffix = [None] * len(s)
        min_suffix[-1] = s[-1]

        for i in range(len(s)-2, -1, -1):
            min_suffix[i] = min(s[i], min_suffix[i+1])

        for i in range(len(s)):
            t.append(s[i])
            while t and (i == len(s)-1 or t[-1] <= min_suffix[i+1]):
                res.append(t.pop())

        return ''.join(res)