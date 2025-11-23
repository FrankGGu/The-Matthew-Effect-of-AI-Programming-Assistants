class Solution:
    def thousandSeparator(self, n: int) -> str:
        s = str(n)
        res = []
        for i in range(len(s)):
            if (len(s) - i) % 3 == 0 and i != 0:
                res.append('.')
            res.append(s[i])
        return ''.join(res)