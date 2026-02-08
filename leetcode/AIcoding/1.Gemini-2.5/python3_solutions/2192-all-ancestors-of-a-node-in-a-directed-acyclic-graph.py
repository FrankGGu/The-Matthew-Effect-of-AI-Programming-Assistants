import collections

class Solution:
    def getAncestors(self, n: int, edges: list[list[int]]) -> list[list[int]]:
        rev_adj = collections.defaultdict(list)
        for u, v in edges:
            rev_adj[v].append(u)

        ans = [set() for _ in range(n)]

        for i in range(n):
            visited = set()

            def dfs(node):
                visited.add(node)
                for neighbor in rev_adj[node]:
                    if neighbor not in visited:
                        dfs(neighbor)

            dfs(i)

            visited.discard(i) 

            ans[i] = sorted(list(visited))

        return ans