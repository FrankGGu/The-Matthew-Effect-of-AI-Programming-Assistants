class Solution:
    def strWithout3a3b(self, a: int, b: int) -> str:
        res = ""
        while a > 0 or b > 0:
            if a > b:
                if len(res) >= 1 and res[-1] == 'a':
                    if b > 0:
                        res += 'b'
                        b -= 1
                    else:
                        break
                else:
                    res += 'a'
                    a -= 1
            elif b > a:
                if len(res) >= 1 and res[-1] == 'b':
                    if a > 0:
                        res += 'a'
                        a -= 1
                    else:
                        break
                else:
                    res += 'b'
                    b -= 1
            else:
                res += 'a'
                a -= 1
                res += 'b'
                b -= 1
        return res