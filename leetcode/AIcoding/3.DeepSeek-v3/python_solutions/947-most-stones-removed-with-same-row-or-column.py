class Solution:
    def removeStones(self, stones: List[List[int]]) -> int:
        parent = {}
        size = {}

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

        for x, y in stones:
            row = -1 - y
            col = x
            if row not in parent:
                parent[row] = row
                size[row] = 1
            if col not in parent:
                parent[col] = col
                size[col] = 1
            union(row, col)

        roots = set()
        for key in parent:
            roots.add(find(key))

        return len(stones) - len(roots)