from collections import defaultdict, deque

class Solution:
    def mostProfitablePath(self, edges: list[list[int]], amount: list[int]) -> int:
        n = len(amount)
        adj = defaultdict(list)
        for u, v in edges:
            adj[u].append(v)
            adj[v].append(u)

        parent = [-1] * n
        dist_bob = [-1] * n
        dist_alice = [-1] * n

        q = deque([(0, -1, 0)])
        dist_alice[0] = 0
        while q:
            u, p, d = q.popleft()
            parent[u] = p
            dist_alice[u] = d
            for v in adj[u]:
                if v != p:
                    q.append((v, u, d + 1))

        q = deque([(n - 1, -1, 0)])
        dist_bob[n - 1] = 0
        while q:
            u, p, d = q.popleft()
            dist_bob[u] = d
            for v in adj[u]:
                if v != p:
                    q.append((v, u, d + 1))

        bob_path = []
        curr = n - 1
        while curr != -1:
            bob_path.append(curr)
            curr = parent[curr]

        profit = float('-inf')

        def dfs(node, par, path_len, current_profit):
            nonlocal profit

            bob_index = -1
            if node in bob_path:
                bob_index = len(bob_path) - 1 - bob_path.index(node)

            if bob_index == path_len:
                current_profit += amount[node] // 2
            elif bob_index > path_len:
                current_profit += amount[node]
            else:
                current_profit += amount[node]

            is_leaf = True
            for neighbor in adj[node]:
                if neighbor != par:
                    is_leaf = False
                    dfs(neighbor, node, path_len + 1, current_profit)

            if is_leaf:
                profit = max(profit, current_profit)

        dfs(0, -1, 0, 0)
        return profit