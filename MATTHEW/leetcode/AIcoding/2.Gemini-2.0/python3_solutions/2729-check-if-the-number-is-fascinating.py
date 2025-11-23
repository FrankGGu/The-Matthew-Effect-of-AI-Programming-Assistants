class Solution:
    def isFascinating(self, n: int) -> bool:
        s = str(n) + str(2 * n) + str(3 * n)
        if len(s) != 9:
            return False

        digits = set(s)
        if len(digits) != 9 or '0' in digits:
            return False

        counts = {}
        for digit in s:
            counts[digit] = counts.get(digit, 0) + 1

        for count in counts.values():
            if count != 1:
                return False

        return True