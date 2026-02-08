import collections

class Solution:
    def findEvenNumbers(self, digits: list[int]) -> list[int]:
        digits_count = collections.Counter(digits)

        result = []

        for num in range(100, 1000, 2):
            d1 = num // 100
            d2 = (num // 10) % 10
            d3 = num % 10

            current_num_digits_count = collections.Counter([d1, d2, d3])

            possible = True
            for digit, count in current_num_digits_count.items():
                if digits_count[digit] < count:
                    possible = False
                    break

            if possible:
                result.append(num)

        return result