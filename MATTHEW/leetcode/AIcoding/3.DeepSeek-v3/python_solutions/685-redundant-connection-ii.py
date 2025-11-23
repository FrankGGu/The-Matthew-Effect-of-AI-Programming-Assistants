class Solution:
    def findRedundantDirectedConnection(self, edges: List[List[int]]) -> List[int]:
        parent = {}
        candidates = []

        for u, v in edges:
            if v in parent:
                candidates.append([parent[v], v])
                candidates.append([u, v])
            else:
                parent[v] = u

        def find(u, root):
            while root[u] != u:
                root[u] = root[root[u]]
                u = root[u]
            return u

        if not candidates:
            root = [i for i in range(len(edges) + 1)]
            for u, v in edges:
                u_root = find(u, root)
                v_root = find(v, root)
                if u_root == v_root:
                    return [u, v]
                root[v_root] = u_root
        else:
            root = [i for i in range(len(edges) + 1)]
            for u, v in edges:
                if [u, v] == candidates[1]:
                    continue
                u_root = find(u, root)
                v_root = find(v, root)
                if u_root == v_root:
                    return candidates[0]
                root[v_root] = u_root
            return candidates[1]