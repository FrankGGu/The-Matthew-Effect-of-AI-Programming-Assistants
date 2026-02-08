class Solution:
    def catMouseGame(self, graph: List[List[int]]) -> int:
        n = len(graph)
        DRAW, MOUSE, CAT = 0, 1, 2
        dp = [[([0] * (2 * n)) for _ in range(n)] for _ in range(n)]
        degree = [[(0) for _ in range(n)] for _ in range(n)]
        for i in range(n):
            for j in range(n):
                degree[i][j] = len(graph[j]) if j != 2 else len(graph[j]) - 1

        q = collections.deque()
        for i in range(n):
            for t in range(2):
                dp[i][i][t] = MOUSE
                dp[2][i][t] = CAT
                if i != 0 and i != 2:
                    q.append((i, i, t, MOUSE))
                    q.append((2, i, t, CAT))

        def get_parent(mouse, cat, turn):
            if turn == 0:
                for prev_cat in graph[cat]:
                    if prev_cat != 0:
                        yield mouse, prev_cat, 1
            else:
                for prev_mouse in graph[mouse]:
                    yield prev_mouse, cat, 0

        while q:
            mouse, cat, turn, result = q.popleft()
            for prev_mouse, prev_cat, prev_turn in get_parent(mouse, cat, turn):
                if dp[prev_mouse][prev_cat][prev_turn] != DRAW:
                    continue
                if prev_turn == 1 and result == CAT or prev_turn == 0 and result == MOUSE:
                    dp[prev_mouse][prev_cat][prev_turn] = result
                    q.append((prev_mouse, prev_cat, prev_turn, result))
                else:
                    degree[prev_mouse][prev_cat] -= 1
                    if degree[prev_mouse][prev_cat] == 0:
                        dp[prev_mouse][prev_cat][prev_turn] = 3 - result
                        q.append((prev_mouse, prev_cat, prev_turn, 3 - result))

        return dp[1][2][0]