import collections

class Solution:
    def isPossible(self, n: int, edges: list[list[int]]) -> bool:
        adj = collections.defaultdict(set)
        degree = collections.defaultdict(int)

        for u, v in edges:
            adj[u].add(v)
            adj[v].add(u)
            degree[u] += 1
            degree[v] += 1

        odd_degree_nodes = []
        for i in range(1, n + 1):
            if degree[i] % 2 != 0:
                odd_degree_nodes.append(i)

        k = len(odd_degree_nodes)

        if k == 0:
            return True
        elif k == 2:
            u, v = odd_degree_nodes[0], odd_degree_nodes[1]

            # Option 1: Add one edge (u, v)
            # This makes both u and v's degrees even.
            if v not in adj[u]:
                return True

            # Option 2: Add two edges (u, x) and (v, x) for some node x
            # This makes both u and v's degrees even.
            # The degree of x changes by 2, so its parity remains the same.
            for x in range(1, n + 1):
                # We need to ensure that (u,x) and (v,x) are not existing edges
                # before we can add them.
                if x not in adj[u] and x not in adj[v]:
                    return True
            return False

        elif k == 4:
            a, b, c, d = odd_degree_nodes[0], odd_degree_nodes[1], odd_degree_nodes[2], odd_degree_nodes[3]

            # Try pairing (a,b) and (c,d)
            # This makes a, b, c, d's degrees even.
            if b not in adj[a] and d not in adj[c]:
                return True

            # Try pairing (a,c) and (b,d)
            # This makes a, c, b, d's degrees even.
            if c not in adj[a] and d not in adj[b]:
                return True

            # Try pairing (a,d) and (b,c)
            # This makes a, d, b, c's degrees even.
            if d not in adj[a] and c not in adj[b]:
                return True

            return False

        else: # k must be even, so if not 0, 2, or 4, then k >= 6
            # With k >= 6 odd-degree nodes, it's impossible to make all degrees even
            # by adding at most two edges. Each edge can fix at most two odd degrees.
            return False