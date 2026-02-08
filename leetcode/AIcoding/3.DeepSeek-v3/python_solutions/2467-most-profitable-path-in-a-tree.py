class Solution:
    def mostProfitablePath(self, edges: List[List[int]], bob: int, amount: List[int]) -> int:
        n = len(edges) + 1
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        parent = [0] * n
        depth = [0] * n
        q = deque()
        q.append(0)
        parent[0] = -1

        while q:
            u = q.popleft()
            for v in graph[u]:
                if v != parent[u]:
                    parent[v] = u
                    depth[v] = depth[u] + 1
                    q.append(v)

        path = []
        u = bob
        while u != -1:
            path.append(u)
            u = parent[u]
        path = path[::-1]

        time = [0] * n
        for t, node in enumerate(path):
            time[node] = t

        max_profit = -float('inf')
        q = deque([(0, 0, amount[0])])

        while q:
            u, t, profit = q.popleft()
            if u != 0 and len(graph[u]) == 1:
                max_profit = max(max_profit, profit)
                continue

            for v in graph[u]:
                if v != parent[u]:
                    new_t = t + 1
                    if time[v] == 0 or new_t < time[v]:
                        new_profit = profit + amount[v]
                    elif new_t == time[v]:
                        new_profit = profit + amount[v] // 2
                    else:
                        new_profit = profit
                    q.append((v, new_t, new_profit))

        return max_profit