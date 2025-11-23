class Solution:
    def password(self, s: str) -> str:
        res = []
        for c in s:
            if c == '#':
                if res:
                    res.pop()
            else:
                res.append(c)
        return ''.join(res)