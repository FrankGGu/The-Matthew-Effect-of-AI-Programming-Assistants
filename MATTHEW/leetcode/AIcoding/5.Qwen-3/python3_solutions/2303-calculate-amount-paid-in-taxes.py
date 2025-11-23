class Solution:
    def calculateTax(self, brackets: List[List[int]], income: int) -> float:
        tax = 0.0
        prev = 0
        for level, percent in brackets:
            if income <= 0:
                break
            current = min(income, level - prev)
            tax += current * percent / 100
            income -= current
            prev = level
        return tax