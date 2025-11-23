from fractions import Fraction

class Solution:
    def isRationalEqual(self, s: str, t: str) -> bool:
        return self._parse_rational_to_fraction(s) == self._parse_rational_to_fraction(t)

    def _parse_rational_to_fraction(self, s: str) -> Fraction:
        if '(' not in s:
            return Fraction(s)

        parts = s.split('(')
        non_repeating_part_str = parts[0]
        repeating_part_str = parts[1][:-1]

        integer_part = 0
        non_repeating_decimal_str = ""

        if '.' in non_repeating_part_str:
            int_and_non_rep_dec_parts = non_repeating_part_str.split('.')
            if int_and_non_rep_dec_parts[0]:
                integer_part = int(int_and_non_rep_dec_parts[0])
            non_repeating_decimal_str = int_and_non_rep_dec_parts[1]
        else:
            integer_part = int(non_repeating_part_str)

        non_repeating_decimal_len = len(non_repeating_decimal_str)
        non_repeating_decimal_val = int(non_repeating_decimal_str) if non_repeating_decimal_str else 0

        repeating_len = len(repeating_part_str)
        repeating_val = int(repeating_part_str) if repeating_part_str else 0

        result_fraction = Fraction(integer_part)

        if non_repeating_decimal_len > 0:
            result_fraction += Fraction(non_repeating_decimal_val, 10**non_repeating_decimal_len)

        if repeating_len > 0:
            denominator_for_repeating = (10**repeating_len - 1) * (10**non_repeating_decimal_len)
            result_fraction += Fraction(repeating_val, denominator_for_repeating)

        return result_fraction