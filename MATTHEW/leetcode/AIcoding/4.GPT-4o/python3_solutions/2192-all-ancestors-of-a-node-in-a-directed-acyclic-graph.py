class Solution:
    def getAncestors(self, n: int, edges: List[List[int]]) -> List[List[int]]:
        graph = defaultdict(list)
        for parent, child in edges:
            graph[child].append(parent)

        def dfs(node):
            if node in visited:
                return
            visited.add(node)
            for neighbor in graph[node]:
                dfs(neighbor)
                ancestors[node].add(neighbor)
                ancestors[node].update(ancestors[neighbor])

        ancestors = [set() for _ in range(n)]
        visited = set()

        for i in range(n):
            if i not in visited:
                dfs(i)

        return [sorted(list(ancestors[i])) for i in range(n)]