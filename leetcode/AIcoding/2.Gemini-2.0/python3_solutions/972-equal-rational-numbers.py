class Solution:
    def isRationalEqual(self, s: str, t: str) -> bool:
        def to_float(s: str) -> float:
            if '.' not in s:
                return float(s)
            integer_part, decimal_part = s.split('.')
            if '(' not in decimal_part:
                return float(s)
            non_repeating, repeating = decimal_part.split('(')
            repeating = repeating[:-1]
            if not repeating:
                return float(s)
            num_non_repeating = len(non_repeating)
            num_repeating = len(repeating)
            num = int(integer_part + non_repeating + repeating) - int(integer_part + non_repeating)
            den = 10 ** (num_non_repeating + num_repeating) - 10 ** num_non_repeating
            return int(integer_part) + num / den

        return abs(to_float(s) - to_float(t)) < 1e-9