class Solution:
    def countValidPaths(self, n: int, edges: List[List[int]]) -> int:
        from collections import defaultdict

        tree = defaultdict(list)
        for u, v in edges:
            tree[u].append(v)
            tree[v].append(u)

        result = 0

        def dfs(node, parent):
            nonlocal result
            count = 1
            for neighbor in tree[node]:
                if neighbor != parent:
                    child_count = dfs(neighbor, node)
                    if child_count % 2 == 1:
                        result += 1
                    count += child_count
            return count

        dfs(1, -1)
        return result