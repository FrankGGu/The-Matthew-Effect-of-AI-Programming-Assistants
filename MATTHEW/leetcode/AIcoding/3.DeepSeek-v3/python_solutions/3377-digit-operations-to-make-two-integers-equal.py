class Solution:
    def makeIntegerBeautiful(self, n: int, target: int) -> int:
        def digit_sum(num):
            s = 0
            while num > 0:
                s += num % 10
                num = num // 10
            return s

        original = n
        add = 0
        power = 1

        while digit_sum(n + add) > target:
            next_add = (10 - (n // power) % 10) * power
            add += next_add
            power *= 10

        return add