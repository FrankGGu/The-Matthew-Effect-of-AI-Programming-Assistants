class Solution:
    def minScore(self, n: int, roads: List[List[int]]) -> int:
        parent = [i for i in range(n + 1)]

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            root_u = find(u)
            root_v = find(v)
            if root_u != root_v:
                parent[root_v] = root_u

        for u, v, d in roads:
            union(u, v)

        min_score = float('inf')
        root_1 = find(1)
        for u, v, d in roads:
            if find(u) == root_1 or find(v) == root_1:
                min_score = min(min_score, d)

        return min_score