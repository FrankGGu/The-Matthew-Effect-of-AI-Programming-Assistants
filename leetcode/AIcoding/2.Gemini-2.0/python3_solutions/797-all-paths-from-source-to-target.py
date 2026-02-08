class Solution:
    def allPathsSourceTarget(self, graph: List[List[int]]) -> List[List[int]]:
        target = len(graph) - 1
        paths = []

        def dfs(node, path):
            if node == target:
                paths.append(path)
                return

            for neighbor in graph[node]:
                dfs(neighbor, path + [neighbor])

        dfs(0, [0])
        return paths