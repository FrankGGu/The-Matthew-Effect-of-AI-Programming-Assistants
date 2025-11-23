class Solution:
    def isRationalEqual(self, S: str, T: str) -> bool:
        def parse_number(s: str) -> float:
            if '.' in s:
                whole, frac = s.split('.')
                whole = int(whole) if whole else 0
                frac = frac.rstrip('0')  # Remove trailing zeros
                frac_value = sum(int(digit) * (10 ** -(i + 1)) for i, digit in enumerate(frac))
                return whole + frac_value
            return int(s)

        return parse_number(S) == parse_number(T)