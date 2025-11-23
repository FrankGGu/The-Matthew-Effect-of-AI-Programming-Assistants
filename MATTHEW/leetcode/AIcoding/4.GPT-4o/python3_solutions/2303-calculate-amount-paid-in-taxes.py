class Solution:
    def calculateTax(self, brackets: List[List[int]], income: int) -> float:
        tax = 0.0
        previous_limit = 0

        for limit, rate in brackets:
            if income > limit:
                tax += (limit - previous_limit) * (rate / 100)
                previous_limit = limit
            else:
                tax += (income - previous_limit) * (rate / 100)
                break

        return tax