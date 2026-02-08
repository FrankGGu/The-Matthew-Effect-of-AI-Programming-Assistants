class Solution:
    def findRedundantDirectedConnection(self, edges: List[List[int]]) -> List[int]:
        n = len(edges)
        parent = list(range(n + 1))

        def find(x):
            if parent[x] != x:
                parent[x] = find(parent[x])
            return parent[x]

        def union(x, y):
            parent[find(x)] = find(y)

        in_degree = [0] * (n + 1)
        for u, v in edges:
            in_degree[v] += 1

        cand1, cand2 = None, None
        edges_to_check = []
        for u, v in edges:
            if in_degree[v] > 1:
                if cand1 is None:
                    cand1 = [u, v]
                else:
                    cand2 = [u, v]
            else:
                edges_to_check.append([u, v])

        if cand1 is not None:
            if cand2 is not None:
                edges_to_check.append(cand2)

                parent = list(range(n + 1))

                for u, v in edges_to_check:
                    if find(u) == find(v):
                        return cand2
                    union(u, v)

                return cand1

            else:
                edges_to_check.append(cand1)
                parent = list(range(n + 1))

                for u, v in edges_to_check:
                    if find(u) == find(v):
                        return cand1
                    union(u, v)

        parent = list(range(n + 1))

        for u, v in edges:
            if find(u) == find(v):
                return [u, v]
            union(u, v)

        return None