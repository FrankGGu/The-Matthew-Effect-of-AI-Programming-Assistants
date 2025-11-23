class Solution:
    def findSubtreeSizes(self, n: int, edges: List[List[int]], changes: List[int]) -> List[int]:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        sizes = [0] * (n + 1)

        def dfs(node, parent):
            size = 1
            for neighbor in tree[node]:
                if neighbor != parent:
                    size += dfs(neighbor, node)
            sizes[node] = size
            return size

        dfs(1, -1)

        result = []
        for change in changes:
            result.append(sizes[change])

        return result