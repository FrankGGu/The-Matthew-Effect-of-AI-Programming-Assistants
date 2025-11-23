class Solution:
    def largestMultipleOfThree(self, digits: List[int]) -> str:
        total = sum(digits)
        digits.sort(reverse=True)

        if total % 3 == 1:
            mod1 = [d for d in digits if d % 3 == 1]
            mod2 = [d for d in digits if d % 3 == 2]
            if mod1:
                digits.remove(mod1[-1])
            else:
                if len(mod2) >= 2:
                    digits.remove(mod2[-1])
                    digits.remove(mod2[-2])
                else:
                    return ""
        elif total % 3 == 2:
            mod1 = [d for d in digits if d % 3 == 1]
            mod2 = [d for d in digits if d % 3 == 2]
            if mod2:
                digits.remove(mod2[-1])
            else:
                if len(mod1) >= 2:
                    digits.remove(mod1[-1])
                    digits.remove(mod1[-2])
                else:
                    return ""

        if not digits:
            return ""
        if digits[0] == 0:
            return "0"
        return ''.join(map(str, digits))