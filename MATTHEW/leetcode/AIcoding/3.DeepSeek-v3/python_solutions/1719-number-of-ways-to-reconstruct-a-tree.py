class Solution:
    def checkWays(self, pairs: List[List[int]]) -> int:
        from collections import defaultdict

        adj = defaultdict(set)
        for u, v in pairs:
            adj[u].add(v)
            adj[v].add(u)

        nodes = sorted(adj.keys(), key=lambda x: -len(adj[x]))
        n = len(nodes)
        if len(adj[nodes[0]]) != n - 1:
            return 0

        res = 1
        parent = {}
        parent[nodes[0]] = None

        for i in range(1, n):
            u = nodes[i]
            found_parent = False
            for j in range(i):
                v = nodes[j]
                if u in adj[v]:
                    if all(x in adj[v] for x in adj[u] if x != v):
                        parent[u] = v
                        found_parent = True
                        if len(adj[u]) == len(adj[v]):
                            res = 2
                        break
            if not found_parent:
                return 0

        return res