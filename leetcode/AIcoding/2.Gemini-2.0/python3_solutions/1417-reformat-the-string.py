class Solution:
    def reformat(self, s: str) -> str:
        digits = []
        letters = []
        for char in s:
            if char.isdigit():
                digits.append(char)
            else:
                letters.append(char)

        if abs(len(digits) - len(letters)) > 1:
            return ""

        if len(digits) > len(letters):
            longer = digits
            shorter = letters
        else:
            longer = letters
            shorter = digits

        result = ""
        for i in range(len(shorter)):
            result += longer[i]
            result += shorter[i]

        if len(longer) > len(shorter):
            result += longer[-1]

        return result