from collections import Counter

class Solution:
    def findEvenNumbers(self, digits: list[int]) -> list[int]:
        count = Counter(digits)
        result = []
        for i in range(100, 1000, 2):
            num_str = str(i)
            num_count = Counter(num_str)
            valid = True
            for digit, freq in num_count.items():
                if count[int(digit)] < freq:
                    valid = False
                    break
            if valid:
                result.append(i)
        return sorted(result)