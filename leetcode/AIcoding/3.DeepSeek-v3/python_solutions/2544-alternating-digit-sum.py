class Solution:
    def alternateDigitSum(self, n: int) -> int:
        s = str(n)
        total = 0
        for i, ch in enumerate(s):
            num = int(ch)
            if i % 2 == 0:
                total += num
            else:
                total -= num
        return total