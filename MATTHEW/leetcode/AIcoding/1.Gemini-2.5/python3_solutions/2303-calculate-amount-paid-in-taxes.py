class Solution:
    def calculateTax(self, brackets: list[list[int]], income: int) -> float:
        total_tax = 0.0
        prev_upper = 0

        for upper, percent in brackets:
            taxable_in_current_bracket = min(income, upper) - prev_upper

            if taxable_in_current_bracket > 0:
                total_tax += taxable_in_current_bracket * (percent / 100.0)

            prev_upper = upper

            if income <= upper:
                break

        return total_tax