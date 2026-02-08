class Solution:
    def blockPlacementQueries(self, n: int, queries: List[List[int]]) -> List[int]:
        parent = list(range(n + 2))  # 1-based to n
        size = [1] * (n + 2)

        def find(u):
            while parent[u] != u:
                parent[u] = parent[parent[u]]
                u = parent[u]
            return u

        def union(u, v):
            u_root = find(u)
            v_root = find(v)
            if u_root == v_root:
                return
            if size[u_root] < size[v_root]:
                u_root, v_root = v_root, u_root
            parent[v_root] = u_root
            size[u_root] += size[v_root]

        res = []
        blocks = set()
        for query in queries:
            if query[0] == 1:
                x = query[1]
                blocks.add(x)
                if x - 1 in blocks:
                    union(x, x - 1)
                if x + 1 in blocks:
                    union(x, x + 1)
            else:
                x = query[1]
                if x in blocks:
                    res.append(size[find(x)])
                else:
                    res.append(0)
        return res