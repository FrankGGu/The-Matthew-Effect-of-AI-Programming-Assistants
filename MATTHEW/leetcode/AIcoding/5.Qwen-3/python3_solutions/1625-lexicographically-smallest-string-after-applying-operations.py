class Solution:
    def lexSmallestString(self, s: str) -> str:
        n = len(s)
        res = list(s)

        for i in range(n):
            if i % 2 == 0:
                if res[i] > '0':
                    res[i] = chr(ord(res[i]) - 1)
                else:
                    res[i] = '9'
            else:
                if res[i] < '9':
                    res[i] = chr(ord(res[i]) + 1)
                else:
                    res[i] = '0'

        return ''.join(res)