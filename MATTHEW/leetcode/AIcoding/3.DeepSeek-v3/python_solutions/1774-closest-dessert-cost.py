class Solution:
    def closestCost(self, baseCosts: List[int], toppingCosts: List[int], target: int) -> int:
        closest = float('inf')
        n = len(toppingCosts)

        def backtrack(index, current_cost):
            nonlocal closest
            if abs(current_cost - target) < abs(closest - target):
                closest = current_cost
            elif abs(current_cost - target) == abs(closest - target):
                if current_cost < closest:
                    closest = current_cost

            if index == n or current_cost >= target:
                return

            for k in range(3):
                backtrack(index + 1, current_cost + k * toppingCosts[index])

        for base in baseCosts:
            backtrack(0, base)

        return closest