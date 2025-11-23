class Solution:
    def fraction(self, cont: List[int]) -> List[int]:
        numerator = cont[-1]
        denominator = 1
        for i in range(len(cont) - 2, -1, -1):
            numerator, denominator = denominator + numerator * cont[i], numerator
        return [numerator, denominator]