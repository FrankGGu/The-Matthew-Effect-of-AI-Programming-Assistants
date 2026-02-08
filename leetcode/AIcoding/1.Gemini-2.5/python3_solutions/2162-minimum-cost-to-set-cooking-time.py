import math

class Solution:
    def minCostSetTime(self, targetSeconds: int, pushCost: int, moveCost: int) -> int:

        def calculate_cost(digits_sequence, push_cost, move_cost):
            total_cost = 0
            current_digit_pos = 0
            for digit in digits_sequence:
                total_cost += abs(digit - current_digit_pos) * move_cost
                total_cost += push_cost
                current_digit_pos = digit
            return total_cost

        min_total_cost = float('inf')

        min_m = max(0, math.ceil((targetSeconds - 59) / 60))
        max_m = math.floor(targetSeconds / 60)

        for m in range(min_m, max_m + 1):
            s = targetSeconds - m * 60

            if 0 <= s <= 59:
                s_minutes = str(m)
                s_seconds = str(s).zfill(2)

                combined_str = s_minutes + s_seconds
                final_str = str(int(combined_str))

                digits_sequence = [int(d) for d in final_str]

                current_cost = calculate_cost(digits_sequence, pushCost, moveCost)
                min_total_cost = min(min_total_cost, current_cost)

        return min_total_cost