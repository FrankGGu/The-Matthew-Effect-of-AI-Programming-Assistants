class Solution:
    def closestCost(self, baseCosts: list[int], toppingCosts: list[int], target: int) -> int:

        possible_topping_sums = set()

        def generate_topping_sums(index, current_sum):
            if index == len(toppingCosts):
                possible_topping_sums.add(current_sum)
                return

            generate_topping_sums(index + 1, current_sum)
            generate_topping_sums(index + 1, current_sum + toppingCosts[index])
            generate_topping_sums(index + 1, current_sum + 2 * toppingCosts[index])

        generate_topping_sums(0, 0)

        min_diff = float('inf')
        closest_cost = float('inf')

        for base_cost in baseCosts:
            for topping_sum in possible_topping_sums:
                current_dessert_cost = base_cost + topping_sum

                diff = abs(current_dessert_cost - target)

                if diff < min_diff:
                    min_diff = diff
                    closest_cost = current_dessert_cost
                elif diff == min_diff:
                    closest_cost = min(closest_cost, current_dessert_cost)

        return closest_cost