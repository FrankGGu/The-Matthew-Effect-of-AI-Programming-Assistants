class Solution:
    def findEvenNumbers(self, digits: List[int]) -> List[int]:
        from collections import Counter

        count = Counter(digits)
        result = []

        for i in range(100, 1000):
            if i % 2 == 0:
                str_i = str(i)
                if all(count[int(d)] > (d == 0) for d in str_i):
                    result.append(i)

        return sorted(result)