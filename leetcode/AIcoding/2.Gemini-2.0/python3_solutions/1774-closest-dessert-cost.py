class Solution:
    def closestCost(self, baseCosts: list[int], toppingCosts: list[int], target: int) -> int:
        closest = float('inf')
        def backtrack(index, current_cost):
            nonlocal closest
            if abs(current_cost - target) < abs(closest - target):
                closest = current_cost
            elif abs(current_cost - target) == abs(closest - target):
                closest = min(closest, current_cost)

            if index == len(toppingCosts):
                return

            if current_cost > target and current_cost - target > abs(closest-target):
                return 

            backtrack(index + 1, current_cost)
            backtrack(index + 1, current_cost + toppingCosts[index])
            backtrack(index + 1, current_cost + 2 * toppingCosts[index])

        for base_cost in baseCosts:
            backtrack(0, base_cost)

        return closest