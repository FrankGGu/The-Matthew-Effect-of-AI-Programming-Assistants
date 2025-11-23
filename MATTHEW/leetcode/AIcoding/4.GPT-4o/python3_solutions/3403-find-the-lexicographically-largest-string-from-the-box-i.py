class Solution:
    def findLargestString(self, s: str, n: int) -> str:
        res = []
        for i in range(n):
            res.append('z')
        for i in range(n):
            if s[i] == '1':
                res[i] = 'a'
        return ''.join(res)