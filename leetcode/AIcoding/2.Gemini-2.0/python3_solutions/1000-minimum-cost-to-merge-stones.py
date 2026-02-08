class Solution:
    def mergeStones(self, stones: list[int], k: int) -> int:
        n = len(stones)
        if (n - 1) % (k - 1) != 0:
            return -1

        prefix_sum = [0] * (n + 1)
        for i in range(n):
            prefix_sum[i + 1] = prefix_sum[i] + stones[i]

        dp = {}

        def solve(i, j):
            if i == j:
                return 0

            if (i, j) in dp:
                return dp[(i, j)]

            cost = float('inf')
            for m in range(i, j, k - 1):
                cost = min(cost, solve(i, m) + solve(m + 1, j))

            if (j - i) % (k - 1) == 0:
                cost += prefix_sum[j + 1] - prefix_sum[i]

            dp[(i, j)] = cost
            return cost

        return solve(0, n - 1)