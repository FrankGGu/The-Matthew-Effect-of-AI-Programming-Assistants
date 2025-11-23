import math

class Solution:
    def fraction(self, cont: List[int]) -> List[int]:
        n = len(cont)
        if n == 1:
            return [cont[0], 1]

        numerator = cont[-1]
        denominator = 1

        for i in range(n - 2, -1, -1):
            temp = numerator
            numerator = cont[i] * numerator + denominator
            denominator = temp

        return [numerator, denominator]