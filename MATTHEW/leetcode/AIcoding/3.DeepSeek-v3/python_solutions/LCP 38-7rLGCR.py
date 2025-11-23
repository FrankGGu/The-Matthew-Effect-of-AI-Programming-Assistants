class Solution:
    def guardCastle(self, grid: List[str]) -> int:
        m, n = len(grid), len(grid[0])
        INF = float('inf')

        def get_state(s):
            state = []
            for c in s:
                if c == 'C':
                    state.append(1)
                elif c == 'S':
                    state.append(2)
                elif c == '.':
                    state.append(0)
                elif c == '#':
                    state.append(-1)
                elif c == 'P':
                    state.append(3)
            return state

        grid0 = get_state(grid[0])
        grid1 = get_state(grid[1])

        dp = [[[INF] * 4 for _ in range(4)] for __ in range(n)]

        if grid0[0] == 0 and grid1[0] == 0:
            dp[0][0][0] = 0
        if grid0[0] == 0 and grid1[0] == 1:
            dp[0][0][1] = 0
        if grid0[0] == 1 and grid1[0] == 0:
            dp[0][1][0] = 0
        if grid0[0] == 0 and grid1[0] == 2:
            dp[0][0][2] = 0
        if grid0[0] == 2 and grid1[0] == 0:
            dp[0][2][0] = 0
        if grid0[0] == 1 and grid1[0] == 1:
            return -1
        if grid0[0] == 2 and grid1[0] == 2:
            return -1
        if grid0[0] == 1 and grid1[0] == 2:
            return -1
        if grid0[0] == 2 and grid1[0] == 1:
            return -1

        for i in range(1, n):
            for s0 in range(4):
                for s1 in range(4):
                    if dp[i-1][s0][s1] == INF:
                        continue
                    for t0 in range(4):
                        for t1 in range(4):
                            if grid0[i] != 0 and grid0[i] != t0:
                                continue
                            if grid1[i] != 0 and grid1[i] != t1:
                                continue
                            if (t0 == 1 and t1 == 2) or (t0 == 2 and t1 == 1):
                                continue
                            if (s0 == 1 and t0 == 2) or (s0 == 2 and t0 == 1):
                                continue
                            if (s1 == 1 and t1 == 2) or (s1 == 2 and t1 == 1):
                                continue
                            cost = 0
                            if grid0[i] == 0 and t0 != 0:
                                cost += 1
                            if grid1[i] == 0 and t1 != 0:
                                cost += 1
                            if t0 == 3 or t1 == 3:
                                if (t0 == 3 and s1 == 1) or (t1 == 3 and s0 == 1):
                                    continue
                                if (t0 == 3 and t1 == 2) or (t1 == 3 and t0 == 2):
                                    continue
                            dp[i][t0][t1] = min(dp[i][t0][t1], dp[i-1][s0][s1] + cost)

        res = INF
        for s0 in range(4):
            for s1 in range(4):
                res = min(res, dp[n-1][s0][s1])

        return res if res != INF else -1