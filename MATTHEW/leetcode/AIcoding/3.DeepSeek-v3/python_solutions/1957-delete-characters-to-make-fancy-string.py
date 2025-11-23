class Solution:
    def makeFancyString(self, s: str) -> str:
        if len(s) < 3:
            return s
        res = []
        for char in s:
            if len(res) >= 2 and res[-1] == res[-2] == char:
                continue
            res.append(char)
        return ''.join(res)