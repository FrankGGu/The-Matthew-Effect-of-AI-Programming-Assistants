class Solution:
    def strWithout3a3b(self, a: int, b: int) -> str:
        res = []
        while a > 0 or b > 0:
            write_a = False
            if len(res) >= 2 and res[-1] == res[-2]:
                if res[-1] == 'b':
                    write_a = True
            else:
                if a >= b:
                    write_a = True
            if write_a:
                res.append('a')
                a -= 1
            else:
                res.append('b')
                b -= 1
        return ''.join(res)