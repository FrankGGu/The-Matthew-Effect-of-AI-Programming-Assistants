class Solution:
    def findOriginal(self, s: str) -> str:
        res = []
        i = 0
        while i < len(s):
            if s[i].isdigit():
                num = int(s[i])
                i += 1
                res.append(s[i] * num)
            else:
                res.append(s[i])
            i += 1
        return ''.join(res)