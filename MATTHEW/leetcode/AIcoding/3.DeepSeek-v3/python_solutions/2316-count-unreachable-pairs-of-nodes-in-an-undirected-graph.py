class Solution:
    def countPairs(self, n: int, edges: List[List[int]]) -> int:
        parent = [i for i in range(n)]
        size = [1] * n

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
                parent[u_root] = v_root
                size[v_root] += size[u_root]
            else:
                parent[v_root] = u_root
                size[u_root] += size[v_root]

        for u, v in edges:
            union(u, v)

        groups = set()
        for i in range(n):
            groups.add(find(i))

        group_sizes = [size[i] for i in groups]
        total_pairs = 0
        sum_sizes = 0
        for s in group_sizes:
            total_pairs += sum_sizes * s
            sum_sizes += s

        return total_pairs