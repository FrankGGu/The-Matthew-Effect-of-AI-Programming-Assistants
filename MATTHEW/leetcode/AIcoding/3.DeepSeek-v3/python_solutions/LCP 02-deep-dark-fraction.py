class Solution:
    def fraction(self, cont: List[int]) -> List[int]:
        n = len(cont)
        if n == 0:
            return [0, 1]
        numerator = 1
        denominator = cont[-1]
        for i in range(n - 2, -1, -1):
            numerator, denominator = denominator, cont[i] * denominator + numerator
        return [denominator, numerator]