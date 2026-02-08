class Solution:
    def isPossible(self, n: int, edges: List[List[int]]) -> bool:
        degree = [0] * (n + 1)
        adj = [set() for _ in range(n + 1)]

        for u, v in edges:
            degree[u] += 1
            degree[v] += 1
            adj[u].add(v)
            adj[v].add(u)

        odd_nodes = [i for i in range(1, n + 1) if degree[i] % 2 != 0]

        if len(odd_nodes) == 0:
            return True
        elif len(odd_nodes) == 2:
            a, b = odd_nodes
            if a not in adj[b]:
                return True
            else:
                for c in range(1, n + 1):
                    if c != a and c != b and a not in adj[c] and b not in adj[c]:
                        return True
                return False
        elif len(odd_nodes) == 4:
            a, b, c, d = odd_nodes
            if (a not in adj[b] and c not in adj[d]) or \
               (a not in adj[c] and b not in adj[d]) or \
               (a not in adj[d] and b not in adj[c]):
                return True
            else:
                return False
        else:
            return False