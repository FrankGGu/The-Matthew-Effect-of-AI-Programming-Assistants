class Solution:
    def isFascinating(self, n: int) -> bool:
        s1 = str(n)
        s2 = str(2 * n)
        s3 = str(3 * n)

        concatenated_str = s1 + s2 + s3

        if len(concatenated_str) != 9:
            return False

        seen_digits = set()
        for char_digit in concatenated_str:
            if char_digit == '0':
                return False
            if char_digit in seen_digits:
                return False
            seen_digits.add(char_digit)

        return True