class Solution:
    def reformat(self, s: str) -> str:
        digits = []
        letters = []
        for c in s:
            if c.isdigit():
                digits.append(c)
            else:
                letters.append(c)
        if abs(len(digits) - len(letters)) > 1:
            return ""
        res = []
        if len(digits) > len(letters):
            for i in range(len(letters)):
                res.append(digits[i])
                res.append(letters[i])
            res.append(digits[-1])
        else:
            for i in range(len(digits)):
                res.append(letters[i])
                res.append(digits[i])
            if len(letters) > len(digits):
                res.append(letters[-1])
        return "".join(res)