class Solution:
    def minDifference(self, num: int) -> int:
        s = list(str(num))
        n = len(s)
        if n <= 3:
            return 0
        res = float('inf')
        for i in range(1, 4):
            for j in range(i, n):
                if s[j] != '9':
                    temp = s[:]
                    temp[j] = '9'
                    for k in range(j + 1, n):
                        if temp[k] != '9':
                            temp[k] = '9'
                            val = int(''.join(temp))
                            res = min(res, val - num)
                            temp[k] = s[k]
                    break
        return res