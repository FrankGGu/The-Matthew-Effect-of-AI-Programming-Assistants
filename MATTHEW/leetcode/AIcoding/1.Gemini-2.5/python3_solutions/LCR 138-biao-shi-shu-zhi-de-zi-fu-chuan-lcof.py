class Solution:
    def isNumber(self, s: str) -> bool:
        s = s.strip()

        seen_digit = False
        seen_dot = False
        seen_e = False

        for i, char in enumerate(s):
            if '0' <= char <= '9':
                seen_digit = True
            elif char == '.':
                if seen_dot or seen_e:
                    return False
                seen_dot = True
            elif char == 'e' or char == 'E':
                if seen_e or not seen_digit:
                    return False
                seen_e = True
                seen_digit = False 
            elif char == '+' or char == '-':
                if i > 0 and s[i-1] != 'e' and s[i-1] != 'E':
                    return False
            else:
                return False

        return seen_digit