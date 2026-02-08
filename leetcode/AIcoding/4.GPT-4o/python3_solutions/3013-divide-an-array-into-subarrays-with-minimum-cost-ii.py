class Solution:
    def minCost(self, A: List[int], k: int) -> int:
        n = len(A)
        if k >= n:
            return 0

        cost = [[0] * (k + 1) for _ in range(n + 1)]
        count = [0] * 101

        for i in range(1, n + 1):
            cost[i][1] = 0
            count[A[i - 1]] += 1
            unique = sum(1 for x in count if x > 0)
            cost[i][1] = unique - 1

        for j in range(2, k + 1):
            for i in range(j, n + 1):
                count = [0] * 101
                unique = 0
                cost[i][j] = float('inf')
                for m in range(i, j - 1, -1):
                    count[A[m - 1]] += 1
                    if count[A[m - 1]] == 1:
                        unique += 1
                    current_cost = unique - 1 + cost[m - 1][j - 1]
                    cost[i][j] = min(cost[i][j], current_cost)

        return cost[n][k]