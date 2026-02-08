class Solution:
    def minCostClimbingStairs(self, cost: list[int]) -> int:
        n = len(cost)

        # prev2 stores the minimum cost to reach the top starting from step i+2
        # prev1 stores the minimum cost to reach the top starting from step i+1
        # current_cost stores the minimum cost to reach the top starting from step i

        # Base cases:
        # If we are at the last step (n-1), we pay cost[n-1] and we are at the top.
        # If we are at the second to last step (n-2), we pay cost[n-2] and we are at the top.
        prev2 = cost[n - 1]
        prev1 = cost[n - 2]

        # Iterate from n-3 down to 0
        for i in range(n - 3, -1, -1):
            current_cost = cost[i] + min(prev1, prev2)
            prev2 = prev1
            prev1 = current_cost

        # After the loop:
        # prev1 holds the minimum cost to reach the top starting from step 0.
        # prev2 holds the minimum cost to reach the top starting from step 1.
        # We can start from either step 0 or step 1, so we take the minimum of these two.
        return min(prev1, prev2)