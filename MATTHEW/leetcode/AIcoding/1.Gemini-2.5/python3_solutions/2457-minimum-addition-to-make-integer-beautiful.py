class Solution:
    def sum_digits(self, num: int) -> int:
        s = 0
        while num > 0:
            s += num % 10
            num //= 10
        return s

    def makeBeautiful(self, n: int, target: int) -> int:
        if self.sum_digits(n) <= target:
            return 0

        ans = 0
        power_of_10 = 1

        while self.sum_digits(n) > target:
            remainder = n % (power_of_10 * 10)

            if remainder == 0:
                power_of_10 *= 10
                continue

            needed_to_add = (power_of_10 * 10) - remainder

            ans += needed_to_add
            n += needed_to_add

            power_of_10 *= 10

        return ans