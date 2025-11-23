class Solution:
    def countSubgraphsForEachDiameter(self, n: int, edges: List[List[int]]) -> List[int]:
        from itertools import combinations

        # Build adjacency list
        adj = [[] for _ in range(n)]
        for u, v in edges:
            u -= 1
            v -= 1
            adj[u].append(v)
            adj[v].append(u)

        # Precompute all pairs shortest paths using BFS
        dist = [[0] * n for _ in range(n)]
        for i in range(n):
            visited = [False] * n
            q = [i]
            visited[i] = True
            d = 0
            while q:
                next_q = []
                for u in q:
                    for v in adj[u]:
                        if not visited[v]:
                            visited[v] = True
                            dist[i][v] = d + 1
                            next_q.append(v)
                q = next_q
                d += 1

        res = [0] * (n - 1)
        # Iterate all possible subsets of cities (subtrees)
        for mask in range(1, 1 << n):
            cities = []
            for i in range(n):
                if mask & (1 << i):
                    cities.append(i)
            if len(cities) < 2:
                continue

            # Check if the subset forms a connected subtree
            # Perform BFS to check connectivity
            q = [cities[0]]
            visited = [False] * n
            visited[cities[0]] = True
            count = 1
            while q:
                u = q.pop(0)
                for v in adj[u]:
                    if not visited[v] and (mask & (1 << v)):
                        visited[v] = True
                        q.append(v)
                        count += 1
            if count != len(cities):
                continue

            # Calculate max distance in the subtree
            max_dist = 0
            for u, v in combinations(cities, 2):
                max_dist = max(max_dist, dist[u][v])
            if max_dist >= 1:
                res[max_dist - 1] += 1

        return res