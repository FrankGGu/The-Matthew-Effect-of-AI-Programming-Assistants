import collections

class Solution:
    def findEvenNumbers(self, digits: list[int]) -> list[int]:
        counts = collections.Counter(digits)

        result = []

        for num in range(100, 1000, 2):
            d1 = num // 100
            d2 = (num // 10) % 10
            d3 = num % 10

            temp_counts = collections.Counter([d1, d2, d3])

            can_form = True
            for digit, count in temp_counts.items():
                if counts[digit] < count:
                    can_form = False
                    break

            if can_form:
                result.append(num)

        return result