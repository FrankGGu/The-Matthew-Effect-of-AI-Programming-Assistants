class Solution:
    def minimumCost(self, cost: list[int]) -> int:
        cost.sort(reverse=True)

        total_cost = 0
        n = len(cost)

        i = 0
        while i < n:
            # Pay for the first candy
            total_cost += cost[i]

            # If there's a second candy in the group, pay for it
            if i + 1 < n:
                total_cost += cost[i+1]

            # The third candy (cost[i+2]) is free, so we skip it
            # Move to the next group of three candies
            i += 3

        return total_cost