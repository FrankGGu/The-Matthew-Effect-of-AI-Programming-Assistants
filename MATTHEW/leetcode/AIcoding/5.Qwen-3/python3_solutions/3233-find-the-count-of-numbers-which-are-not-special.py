class Solution:
    def nonSpecialNumbers(self, n: int) -> int:
        def is_square(x):
            s = int(x**0.5)
            return s * s == x

        count = 0
        for i in range(2, n + 1):
            if not is_square(i):
                count += 1
        return count