class Solution:
    def isNumber(self, s: str) -> bool:
        s = s.strip()
        if not s:
            return False

        def is_decimal_part(sub_s: str) -> bool:
            seen_digit = False
            seen_dot = False
            i = 0

            if not sub_s:
                return False

            if i < len(sub_s) and (sub_s[i] == '+' or sub_s[i] == '-'):
                i += 1

            while i < len(sub_s):
                char = sub_s[i]
                if char.isdigit():
                    seen_digit = True
                elif char == '.':
                    if seen_dot:
                        return False
                    seen_dot = True
                else:
                    return False
                i += 1

            return seen_digit

        def is_integer_part(sub_s: str) -> bool:
            seen_digit = False
            i = 0

            if not sub_s:
                return False

            if i < len(sub_s) and (sub_s[i] == '+' or sub_s[i] == '-'):
                i += 1

            while i < len(sub_s):
                char = sub_s[i]
                if char.isdigit():
                    seen_digit = True
                else:
                    return False
                i += 1

            return seen_digit

        e_idx = -1
        for i in range(len(s)):
            if s[i] == 'e' or s[i] == 'E':
                if e_idx != -1:
                    return False
                e_idx = i

        if e_idx == -1:
            return is_decimal_part(s)
        else:
            part1 = s[0:e_idx]
            part2 = s[e_idx+1:]

            if not part1 or not part2:
                return False

            return is_decimal_part(part1) and is_integer_part(part2)