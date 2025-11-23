class Solution:
    def maxProfit(self, customers: list[int], boardingCost: int, runningCost: int) -> int:
        total_customers_waiting = 0
        current_profit = 0
        max_profit = 0
        min_rotations_for_max_profit = -1

        rotations = 0
        i = 0 # Index for customers array

        while i < len(customers) or total_customers_waiting > 0:
            # Customers arrive at the current minute
            if i < len(customers):
                total_customers_waiting += customers[i]
                i += 1

            # Rotate the wheel
            rotations += 1

            # Board customers (max 4 per rotation)
            customers_to_board = min(total_customers_waiting, 4)
            total_customers_waiting -= customers_to_board

            # Update profit
            current_profit += (customers_to_board * boardingCost) - runningCost

            # Check for maximum profit and corresponding minimum rotations
            if current_profit > max_profit:
                max_profit = current_profit
                min_rotations_for_max_profit = rotations

        return min_rotations_for_max_profit