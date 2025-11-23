class Solution:
    def getSmallestString(self, n: int, k: int) -> str:
        res = ['a'] * n
        k -= n
        i = n - 1
        while k > 0:
            add = min(k, 25)
            res[i] = chr(ord('a') + add)
            k -= add
            i -= 1
        return ''.join(res)