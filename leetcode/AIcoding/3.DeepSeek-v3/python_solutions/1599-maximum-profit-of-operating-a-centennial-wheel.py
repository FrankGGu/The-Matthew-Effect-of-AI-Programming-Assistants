class Solution:
    def minOperationsMaxProfit(self, customers: List[int], boardingCost: int, runningCost: int) -> int:
        max_profit = -1
        max_rotations = -1
        current_profit = 0
        remaining_customers = 0
        rotations = 0

        for i in range(len(customers)):
            remaining_customers += customers[i]
            board = min(4, remaining_customers)
            remaining_customers -= board
            current_profit += board * boardingCost - runningCost
            rotations += 1

            if current_profit > max_profit:
                max_profit = current_profit
                max_rotations = rotations

        while remaining_customers > 0:
            board = min(4, remaining_customers)
            remaining_customers -= board
            current_profit += board * boardingCost - runningCost
            rotations += 1

            if current_profit > max_profit:
                max_profit = current_profit
                max_rotations = rotations

        return max_rotations if max_profit > 0 else -1