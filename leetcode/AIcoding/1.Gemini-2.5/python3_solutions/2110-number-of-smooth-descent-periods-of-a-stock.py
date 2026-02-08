class Solution:
    def getDescentPeriods(self, prices: list[int]) -> int:
        n = len(prices)
        if n == 0:
            return 0

        total_periods = 0
        current_descent_length = 0

        for i in range(n):
            if i == 0 or prices[i - 1] - prices[i] == 1:
                current_descent_length += 1
            else:
                current_descent_length = 1

            total_periods += current_descent_length

        return total_periods