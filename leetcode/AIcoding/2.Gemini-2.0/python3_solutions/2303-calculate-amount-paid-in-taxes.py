class Solution:
    def calculateTax(self, brackets: list[list[int]], income: int) -> float:
        tax = 0.0
        prev = 0
        for upper, percent in brackets:
            if income <= 0:
                break
            taxable = min(income, upper - prev)
            tax += taxable * percent / 100
            income -= taxable
            prev = upper
        return tax