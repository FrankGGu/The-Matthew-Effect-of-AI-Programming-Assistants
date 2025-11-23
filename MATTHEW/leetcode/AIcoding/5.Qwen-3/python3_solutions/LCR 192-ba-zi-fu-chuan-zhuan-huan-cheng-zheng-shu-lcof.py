class Solution:
    def myAtoi(self, s: str) -> int:
        import re
        s = s.strip()
        if not s:
            return 0
        sign = 1
        if s[0] == '-':
            sign = -1
            s = s[1:]
        elif s[0] == '+':
            s = s[1:]
        if not s.isdigit():
            match = re.match(r'^\d+', s)
            if match:
                s = match.group()
            else:
                return 0
        result = int(s) * sign
        if result < -2**31:
            return -2**31
        elif result > 2**31 - 1:
            return 2**31 - 1
        else:
            return result