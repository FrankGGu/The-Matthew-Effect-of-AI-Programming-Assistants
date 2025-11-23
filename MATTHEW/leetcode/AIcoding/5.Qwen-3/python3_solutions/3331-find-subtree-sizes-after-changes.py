class Solution:
    def findSubtreeSizes(self, parent: str, s: str) -> List[int]:
        from collections import defaultdict

        tree = defaultdict(list)
        n = len(parent)
        for i in range(1, n):
            tree[int(parent[i])].append(i)

        result = [0] * n

        def dfs(node):
            size = 1
            for child in tree[node]:
                size += dfs(child)
            result[node] = size
            return size

        dfs(0)

        return result