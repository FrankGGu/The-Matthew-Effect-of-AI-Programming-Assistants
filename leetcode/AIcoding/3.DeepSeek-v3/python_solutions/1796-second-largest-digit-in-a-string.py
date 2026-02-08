class Solution:
    def secondHighest(self, s: str) -> int:
        digits = []
        for c in s:
            if c.isdigit():
                digits.append(int(c))
        unique_digits = sorted(list(set(digits)), reverse=True)
        if len(unique_digits) < 2:
            return -1
        return unique_digits[1]