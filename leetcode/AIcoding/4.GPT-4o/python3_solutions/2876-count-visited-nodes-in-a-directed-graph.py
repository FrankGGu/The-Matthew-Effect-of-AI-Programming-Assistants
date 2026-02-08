class Solution:
    def countVisitedNodes(self, edges: List[List[int]]) -> int:
        n = len(edges)
        visited = [False] * n
        graph = defaultdict(list)

        for i in range(n):
            graph[i].append(edges[i])

        def dfs(node):
            if visited[node]:
                return
            visited[node] = True
            for neighbor in graph[node]:
                dfs(neighbor)

        for i in range(n):
            if not visited[i]:
                dfs(i)

        return sum(visited)