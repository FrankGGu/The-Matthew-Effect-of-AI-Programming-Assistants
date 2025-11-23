class Solution:
    def maxSatisfaction(self, satisfaction: list[int]) -> int:
        satisfaction.sort()

        current_sum_of_satisfactions = 0
        current_total_coefficient = 0
        max_total_coefficient = 0

        # Iterate from the largest satisfaction value to the smallest
        # This allows us to greedily decide whether to include a dish
        # based on its impact on the total like-time coefficient.
        for i in range(len(satisfaction) - 1, -1, -1):
            dish_val = satisfaction[i]

            # If we add this dish, it becomes the 'first' dish in the sequence
            # (i.e., it gets coefficient 1 if it's the smallest among chosen dishes).
            # All previously chosen dishes' coefficients increase by 1.
            # So, the new total coefficient is:
            # old_total_coefficient + (sum of all previously chosen dishes) + current_dish_value
            potential_new_total_coefficient = current_total_coefficient + current_sum_of_satisfactions + dish_val

            # If adding this dish increases the total coefficient, we include it.
            # Otherwise, adding it (or any smaller/more negative dishes) will not help,
            # so we stop.
            if potential_new_total_coefficient > current_total_coefficient:
                current_total_coefficient = potential_new_total_coefficient
                current_sum_of_satisfactions += dish_val
                max_total_coefficient = max(max_total_coefficient, current_total_coefficient)
            else:
                break

        return max_total_coefficient