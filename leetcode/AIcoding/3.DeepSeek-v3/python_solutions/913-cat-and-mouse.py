class Solution:
    def catMouseGame(self, graph: List[List[int]]) -> int:
        n = len(graph)
        DRAW, MOUSE, CAT = 0, 1, 2

        color = [[[0] * 3 for _ in range(n)] for __ in range(n)]
        q = collections.deque()

        for i in range(1, n):
            for t in range(1, 3):
                color[0][i][t] = MOUSE
                q.append((0, i, t, MOUSE))
                color[i][i][t] = CAT
                q.append((i, i, t, CAT))

        while q:
            m, c, t, w = q.popleft()
            for (m2, c2, t2) in self.parents(graph, m, c, t):
                if color[m2][c2][t2] == DRAW:
                    if t2 == w:
                        color[m2][c2][t2] = w
                        q.append((m2, c2, t2, w))
                    else:
                        all_win = True
                        for next_node in graph[m2 if t2 == MOUSE else c2]:
                            if t2 == MOUSE:
                                new_m, new_c = next_node, c2
                            else:
                                new_m, new_c = m2, next_node
                            if color[new_m][new_c][3 - t2] != w:
                                all_win = False
                                break
                        if all_win:
                            color[m2][c2][t2] = w
                            q.append((m2, c2, t2, w))
        return color[1][2][1]

    def parents(self, graph, m, c, t):
        res = []
        if t == CAT:
            for m2 in graph[m]:
                res.append((m2, c, 3 - t))
        else:
            for c2 in graph[c]:
                if c2 != 0:
                    res.append((m, c2, 3 - t))
        return res