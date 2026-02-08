import itertools

class Solution:
    def concatenatedDivisibility(self, digits: list[str], k: int) -> int:
        divisible_numbers = set()

        for p in itertools.permutations(digits):
            s = "".join(p)

            if len(s) > 1 and s[0] == '0':
                continue

            num = int(s)

            if num % k == 0:
                divisible_numbers.add(num)

        return len(divisible_numbers)