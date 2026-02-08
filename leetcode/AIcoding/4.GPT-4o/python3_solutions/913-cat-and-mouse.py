class Solution:
    def catMouse(self, graph: List[List[int]]) -> int:
        n = len(graph)
        INF = float('inf')
        dp = [[[INF] * (n + 1) for _ in range(n)] for _ in range(n)]

        for mouse in range(n):
            dp[mouse][0][0] = 0

        for mouse in range(n):
            for cat in range(1, n):
                dp[mouse][cat][0] = 0

        for mouse in range(1, n):
            for cat in range(n):
                dp[0][cat][mouse] = 1

        for moves in range(1, 2 * n):
            for mouse in range(n):
                for cat in range(n):
                    if mouse == cat:
                        dp[mouse][cat][moves] = 2
                    else:
                        for next_mouse in graph[mouse]:
                            for next_cat in graph[cat]:
                                if next_cat != 0:
                                    dp[mouse][cat][moves] = min(dp[mouse][cat][moves], 1 + dp[next_mouse][next_cat][moves - 1])
                                else:
                                    dp[mouse][cat][moves] = min(dp[mouse][cat][moves], 1 + dp[next_mouse][cat][moves - 1])

        return dp[1][1][2 * n - 1]