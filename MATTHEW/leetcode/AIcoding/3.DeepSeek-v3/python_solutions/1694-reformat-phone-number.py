class Solution:
    def reformatNumber(self, number: str) -> str:
        digits = [c for c in number if c.isdigit()]
        n = len(digits)
        res = []
        i = 0
        while i < n:
            if n - i > 4:
                res.append(''.join(digits[i:i+3]))
                i += 3
            else:
                if n - i == 4:
                    res.append(''.join(digits[i:i+2]))
                    res.append(''.join(digits[i+2:i+4]))
                else:
                    res.append(''.join(digits[i:i+n-i]))
                break
        return '-'.join(res)