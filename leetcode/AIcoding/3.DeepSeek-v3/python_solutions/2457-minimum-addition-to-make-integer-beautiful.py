class Solution:
    def makeIntegerBeautiful(self, n: int, target: int) -> int:
        def digit_sum(x):
            s = 0
            while x > 0:
                s += x % 10
                x = x // 10
            return s

        original = n
        add = 0
        power = 1

        while digit_sum(n) > target:
            last_non_zero = n % 10
            to_add = (10 - last_non_zero) * power
            add += to_add
            n += to_add
            n = n // 10
            power *= 10

        return add