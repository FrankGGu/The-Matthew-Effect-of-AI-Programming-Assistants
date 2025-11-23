class Solution:
    def reformatNumber(self, number: str) -> str:
        digits = [d for d in number if d.isdigit()]
        n = len(digits)
        res = []
        i = 0
        while i < n - 4:
            res.append("".join(digits[i:i+3]))
            i += 3
        if n - i == 4:
            res.append("".join(digits[i:i+2]))
            res.append("".join(digits[i+2:i+4]))
        elif n - i == 3:
            res.append("".join(digits[i:i+3]))
        elif n - i == 2:
            res.append("".join(digits[i:i+2]))
        return "-".join(res)