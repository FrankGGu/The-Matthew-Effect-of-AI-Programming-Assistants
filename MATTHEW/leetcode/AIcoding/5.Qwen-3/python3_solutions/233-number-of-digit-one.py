class Solution:
    def countDigitOne(self, n: int) -> int:
        if n < 1:
            return 0
        count = 0
        i = 1
        while i <= n:
            divider = i * 10
            count += (n // divider) * i
            remainder = n % i
            if remainder >= i:
                count += i
            else:
                count += remainder + 1
            i *= 10
        return count