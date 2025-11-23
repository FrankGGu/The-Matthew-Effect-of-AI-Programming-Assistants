import bisect

class Solution:
    def closestCost(self, baseCosts: list[int], toppingCosts: list[int], target: int) -> int:
        possible_topping_sums = {0}

        for cost in toppingCosts:
            new_sums = set()
            for current_sum in possible_topping_sums:
                new_sums.add(current_sum)
                new_sums.add(current_sum + cost)
                new_sums.add(current_sum + 2 * cost)
            possible_topping_sums = new_sums

        topping_sums_list = sorted(list(possible_topping_sums))

        min_diff = float('inf')
        closest_cost = -1

        for base_cost in baseCosts:
            remaining_for_toppings = target - base_cost

            idx = bisect.bisect_left(topping_sums_list, remaining_for_toppings)

            if idx < len(topping_sums_list):
                current_total_cost = base_cost + topping_sums_list[idx]
                diff = abs(current_total_cost - target)

                if diff < min_diff:
                    min_diff = diff
                    closest_cost = current_total_cost
                elif diff == min_diff:
                    closest_cost = min(closest_cost, current_total_cost)

            if idx > 0:
                current_total_cost = base_cost + topping_sums_list[idx - 1]
                diff = abs(current_total_cost - target)

                if diff < min_diff:
                    min_diff = diff
                    closest_cost = current_total_cost
                elif diff == min_diff:
                    closest_cost = min(closest_cost, current_total_cost)

        return closest_cost