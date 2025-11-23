class Solution:
    def isRationalEqual(self, S: str, T: str) -> bool:
        def convert(s):
            if '(' not in s:
                return float(s)
            integer_part, rest = s.split('.')
            non_repeating, repeating = rest.split('(')
            repeating = repeating[:-1]
            decimal_part = non_repeating + repeating * 20
            return float(integer_part + '.' + decimal_part[:20])
        return abs(convert(S) - convert(T)) < 1e-12