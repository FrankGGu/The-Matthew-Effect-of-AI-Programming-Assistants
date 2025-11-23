class Solution:
    def minCostClimbingStairs(self, cost: list[int]) -> int:
        n = len(cost)

        # prev2 stores the minimum cost to reach step i-2 (after climbing it)
        # prev1 stores the minimum cost to reach step i-1 (after climbing it)
        # The problem guarantees n is at least 2, so cost[0] and cost[1] exist.
        prev2 = cost[0]
        prev1 = cost[1]

        # Iterate from step 2 up to n-1
        for i in range(2, n):
            # The minimum cost to reach step i (after climbing it)
            # is cost[i] plus the minimum cost to reach either step i-1 or i-2.
            current = cost[i] + min(prev1, prev2)
            prev2 = prev1
            prev1 = current

        # The final answer is the minimum cost to reach the top of the floor.
        # This means we either finished climbing step n-1 or step n-2.
        # The accumulated cost to finish climbing step n-1 is prev1.
        # The accumulated cost to finish climbing step n-2 is prev2.
        return min(prev1, prev2)