class Solution:
    def catMouseGame(self, graph: List[List[int]]) -> int:
        n = len(graph)
        # dp[mouse][cat][turn] = winner (0: mouse, 1: cat, 2: draw)
        dp = [[[2] * 2 for _ in range(n)] for _ in range(n)]

        for mouse in range(n):
            dp[mouse][mouse][0] = 1

        for cat in range(1, n):
            dp[0][cat][1] = 0

        for turn in range(2 * n):
            for mouse in range(n):
                for cat in range(n):
                    if mouse == cat:
                        continue
                    if turn % 2 == 0:
                        for next_mouse in graph[mouse]:
                            if dp[next_mouse][cat][1] == 0:
                                dp[mouse][cat][0] = 1
                            if dp[next_mouse][cat][0] == 1:
                                dp[mouse][cat][0] = 0
                    else:
                        for next_cat in graph[cat]:
                            if next_cat == 0:
                                continue
                            if dp[mouse][next_cat][0] == 1:
                                dp[mouse][cat][1] = 0
                            if dp[mouse][next_cat][1] == 0:
                                dp[mouse][cat][1] = 1

        return dp[1][2][0]