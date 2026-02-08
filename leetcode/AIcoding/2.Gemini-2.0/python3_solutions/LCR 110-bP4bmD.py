class Solution:
    def allPathsSourceTarget(self, graph: List[List[int]]) -> List[List[int]]:
        n = len(graph)
        result = []

        def dfs(node, path):
            path.append(node)
            if node == n - 1:
                result.append(path.copy())
            else:
                for neighbor in graph[node]:
                    dfs(neighbor, path)
            path.pop()

        dfs(0, [])
        return result