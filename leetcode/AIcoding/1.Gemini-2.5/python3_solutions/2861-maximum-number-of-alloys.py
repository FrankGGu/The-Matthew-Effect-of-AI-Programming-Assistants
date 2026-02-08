class Solution:
    def maxNumberOfAlloys(self, n: int, k: int, budget: int, composition: list[list[int]], stock: list[int], cost: list[int]) -> int:

        def check(x: int) -> bool:
            # Try to make x alloys
            # Iterate through each factory
            for j in range(k):
                current_factory_cost = 0
                # For each metal type
                for i in range(n):
                    required_metal = composition[j][i] * x

                    if required_metal > stock[i]:
                        # Need to buy metal
                        metal_to_buy = required_metal - stock[i]
                        current_factory_cost += metal_to_buy * cost[i]

                    # Optimization: if cost exceeds budget, this factory cannot make x alloys
                    if current_factory_cost > budget:
                        break # No need to check other metals for this factory

                # If this factory can make x alloys within budget, return True
                if current_factory_cost <= budget:
                    return True

            # No factory could make x alloys
            return False

        low = 0
        high = 2 * 10**9 + 7 # A sufficiently large upper bound for the number of alloys
        ans = 0

        while low <= high:
            mid = low + (high - low) // 2
            if check(mid):
                ans = mid
                low = mid + 1
            else:
                high = mid - 1

        return ans