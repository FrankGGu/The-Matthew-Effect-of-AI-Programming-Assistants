class Solution:
    def minOperationsMaxProfit(self, customers: List[int], boardingCost: int, runningCost: int) -> int:
        total_customers = 0
        waiting = 0
        profit = 0
        max_profit = -1
        operations = 0
        max_operations = -1

        for customer in customers:
            total_customers += customer
            waiting += customer
            board = min(4, waiting)
            waiting -= board
            profit += board * boardingCost - runningCost
            operations += 1

            if profit > max_profit:
                max_profit = profit
                max_operations = operations

        while waiting > 0:
            board = min(4, waiting)
            waiting -= board
            profit += board * boardingCost - runningCost
            operations += 1

            if profit > max_profit:
                max_profit = profit
                max_operations = operations

        if max_profit <= 0:
            return -1
        else:
            return max_operations