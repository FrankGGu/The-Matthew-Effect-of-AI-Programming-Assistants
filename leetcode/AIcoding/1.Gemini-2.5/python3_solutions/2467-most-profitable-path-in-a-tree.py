import collections

class Solution:
    def mostProfitablePath(self, n: int, edges: list[list[int]], bob: int, amount: list[int]) -> int:
        adj = [[] for _ in range(n)]
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        parent = [-1] * n
        dist_from_0 = [-1] * n

        q = collections.deque([(0, 0)])
        dist_from_0[0] = 0

        while q:
            u, d = q.popleft()
            for v in adj[u]:
                if dist_from_0[v] == -1:
                    dist_from_0[v] = d + 1
                    parent[v] = u
                    q.append((v, d + 1))

        bob_reach_time = {}
        bob_path_length = dist_from_0[bob]

        curr = bob
        while curr != -1:
            bob_reach_time[curr] = bob_path_length - dist_from_0[curr]
            curr = parent[curr]

        max_profit = -float('inf')

        def dfs(u, p, current_profit, current_time):
            nonlocal max_profit

            node_profit = 0
            if u in bob_reach_time:
                if current_time < bob_reach_time[u]:
                    node_profit = amount[u]
                elif current_time == bob_reach_time[u]:
                    node_profit = amount[u] / 2
                else:
                    node_profit = 0
            else:
                node_profit = amount[u]

            current_profit += node_profit

            is_leaf = True
            for v in adj[u]:
                if v != p:
                    is_leaf = False
                    dfs(v, u, current_profit, current_time + 1)

            if is_leaf:
                max_profit = max(max_profit, current_profit)

        dfs(0, -1, 0, 0)

        return int(max_profit)