class Solution:
    def isNumber(self, s: str) -> bool:
        s = s.strip()
        has_e = False
        has_dot = False
        has_digit = False

        for i, char in enumerate(s):
            if char.isdigit():
                has_digit = True
            elif char == '+':
                if i != 0 and s[i - 1] != 'e' and s[i - 1] != 'E':
                    return False
            elif char == '-':
                if i != 0 and s[i - 1] != 'e' and s[i - 1] != 'E':
                    return False
            elif char == '.':
                if has_dot or has_e:
                    return False
                has_dot = True
            elif char == 'e' or char == 'E':
                if has_e or not has_digit:
                    return False
                has_e = True
                has_digit = False
            else:
                return False

        return has_digit