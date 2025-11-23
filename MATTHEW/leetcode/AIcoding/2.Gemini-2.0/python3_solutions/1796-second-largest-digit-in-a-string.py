class Solution:
    def secondHighest(self, s: str) -> int:
        digits = set()
        for char in s:
            if char.isdigit():
                digits.add(int(char))

        if len(digits) < 2:
            return -1

        digits = sorted(list(digits), reverse=True)
        return digits[1]