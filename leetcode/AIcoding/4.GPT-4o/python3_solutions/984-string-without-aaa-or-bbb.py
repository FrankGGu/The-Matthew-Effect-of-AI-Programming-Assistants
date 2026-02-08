class Solution:
    def strWithout3a3b(self, A: int, B: int) -> str:
        res = []
        while A > 0 or B > 0:
            if A > B:
                if A > 1:
                    res.append('aa')
                    A -= 2
                else:
                    res.append('a')
                    A -= 1
                if B > 0:
                    res.append('b')
                    B -= 1
            else:
                if B > 1:
                    res.append('bb')
                    B -= 2
                else:
                    res.append('b')
                    B -= 1
                if A > 0:
                    res.append('a')
                    A -= 1
        return ''.join(res)