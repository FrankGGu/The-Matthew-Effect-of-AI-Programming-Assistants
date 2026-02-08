class Solution:
    def thousandSeparator(self, n: int) -> str:
        s = str(n)
        res = ""
        count = 0
        for i in range(len(s) - 1, -1, -1):
            res = s[i] + res
            count += 1
            if count == 3 and i != 0:
                res = "." + res
                count = 0
        return res