class Solution:
    def longestPath(self, parent: List[int], s: str) -> int:
        n = len(parent)
        adj = [[] for _ in range(n)]
        for i in range(1, n):
            adj[parent[i]].append(i)

        max_len = 1

        def dfs(node):
            nonlocal max_len

            len1, len2 = 0, 0

            for child in adj[node]:
                child_len = dfs(child)
                if s[node] != s[child]:
                    if child_len > len1:
                        len2 = len1
                        len1 = child_len
                    elif child_len > len2:
                        len2 = child_len

            max_len = max(max_len, len1 + len2 + 1)
            return len1 + 1

        dfs(0)
        return max_len