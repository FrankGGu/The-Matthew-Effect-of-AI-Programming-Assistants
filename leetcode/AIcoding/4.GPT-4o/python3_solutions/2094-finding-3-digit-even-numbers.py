class Solution:
    def findEvenNumbers(self, digits: List[int]) -> List[int]:
        from collections import Counter

        count = Counter(digits)
        result = []

        for i in range(1, 10):
            if count[i] > 0:
                for j in range(0, 10):
                    if count[j] > (1 if j == i else 0):
                        for k in range(0, 10, 2):
                            if count[k] > (1 if k == j else 0) and (k > 0 or (i == 0 and j == 0)):
                                result.append(100 * i + 10 * j + k)

        return sorted(result)