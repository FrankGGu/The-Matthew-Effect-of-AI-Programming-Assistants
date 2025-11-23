class Solution:
    def minAddToMakeIntegerBeautiful(self, n: int, target: int) -> int:
        if n >= target:
            return 0
        digits = []
        temp = n
        while temp > 0:
            digits.append(temp % 10)
            temp //= 10
        digits.reverse()
        length = len(digits)
        for i in range(length):
            if digits[i] < 9:
                digits[i] += 1
                for j in range(i + 1, length):
                    digits[j] = 0
                break
        res = 0
        for i in range(length):
            res = res * 10 + digits[i]
        return res - n