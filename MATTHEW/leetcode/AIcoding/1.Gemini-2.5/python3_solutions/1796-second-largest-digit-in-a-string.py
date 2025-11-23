class Solution:
    def secondLargest(self, s: str) -> int:
        digits = set()
        for char in s:
            if '0' <= char <= '9':
                digits.add(int(char))

        if len(digits) < 2:
            return -1

        sorted_digits = sorted(list(digits), reverse=True)
        return sorted_digits[1]