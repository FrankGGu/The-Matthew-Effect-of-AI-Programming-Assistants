class Solution:
    def findCriticalAndPseudoCriticalEdges(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        m = len(edges)
        for i in range(m):
            edges[i].append(i)

        edges.sort(key=lambda x: x[2])

        def mst_weight(include, exclude):
            parent = list(range(n))

            def find(i):
                if parent[i] == i:
                    return i
                parent[i] = find(parent[i])
                return parent[i]

            def union(i, j):
                root_i = find(i)
                root_j = find(j)
                if root_i != root_j:
                    parent[root_i] = root_j
                    return True
                return False

            weight = 0
            count = 0

            if include != -1:
                u, v, w, _ = edges[include]
                union(u, v)
                weight += w
                count += 1

            for i in range(m):
                if i != exclude and i != include:
                    u, v, w, _ = edges[i]
                    if union(u, v):
                        weight += w
                        count += 1

            if count == n - 1:
                return weight
            else:
                return float('inf')

        min_weight = mst_weight(-1, -1)
        critical = []
        pseudo_critical = []

        for i in range(m):
            if mst_weight(-1, i) > min_weight:
                critical.append(edges[i][3])
            elif mst_weight(i, -1) == min_weight:
                pseudo_critical.append(edges[i][3])

        return [critical, pseudo_critical]