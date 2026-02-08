class Solution:
    def reachableNodes(self, n: int, edges: List[List[int]], restricted: List[int]) -> int:
        graph = [[] for _ in range(n)]
        for u, v in edges:
            graph[u].append(v)
            graph[v].append(u)

        restricted_set = set(restricted)
        visited = [False] * n
        count = 0

        def dfs(node):
            nonlocal count
            visited[node] = True
            count += 1

            for neighbor in graph[node]:
                if not visited[neighbor] and neighbor not in restricted_set:
                    dfs(neighbor)

        if 0 not in restricted_set:
            dfs(0)

        return count