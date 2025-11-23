class Solution:
    def countEven(self, n: int) -> int:
        count = 0
        for i in range(1, n + 1):
            s = 0
            num = i
            while num > 0:
                s += num % 10
                num //= 10
            if s % 2 == 0:
                count += 1
        return count