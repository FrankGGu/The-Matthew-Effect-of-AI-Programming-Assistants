class Solution:
    def reformat(self, s: str) -> str:
        letters = []
        digits = []
        for c in s:
            if c.isalpha():
                letters.append(c)
            else:
                digits.append(c)
        if abs(len(letters) - len(digits)) > 1:
            return ""
        result = []
        i = 0
        j = 0
        if len(letters) > len(digits):
            while i < len(letters) or j < len(digits):
                result.append(letters[i])
                i += 1
                if j < len(digits):
                    result.append(digits[j])
                    j += 1
        else:
            while i < len(letters) or j < len(digits):
                result.append(digits[j])
                j += 1
                if i < len(letters):
                    result.append(letters[i])
                    i += 1
        return ''.join(result)