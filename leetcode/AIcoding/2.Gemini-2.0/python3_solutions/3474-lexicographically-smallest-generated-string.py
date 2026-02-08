class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        res = ['a'] * n
        k -= n
        for i in range(n - 1, -1, -1):
            if k == 0:
                break
            val = min(25, k)
            res[i] = chr(ord('a') + val)
            k -= val
        return ''.join(res)