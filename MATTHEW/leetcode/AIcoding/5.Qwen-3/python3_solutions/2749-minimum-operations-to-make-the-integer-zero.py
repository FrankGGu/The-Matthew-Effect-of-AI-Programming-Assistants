class Solution:
    def minimumOperations(self, num: int) -> int:
        if num == 0:
            return 0
        s = str(num)
        n = len(s)
        res = float('inf')
        for i in range(n - 1):
            if s[i] == '0':
                res = min(res, n - i - 1)
            elif s[i] == '5':
                for j in range(i + 1, n):
                    if s[j] == '0' or s[j] == '5':
                        res = min(res, n - i - 1)
                        break
        return res if res != float('inf') else n