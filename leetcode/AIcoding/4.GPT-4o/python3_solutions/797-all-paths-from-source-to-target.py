from collections import defaultdict

class Solution:
    def allPathsSourceTarget(self, graph):
        result = []
        n = len(graph)

        def backtrack(node, path):
            if node == n - 1:
                result.append(path[:])
                return
            for neighbor in graph[node]:
                path.append(neighbor)
                backtrack(neighbor, path)
                path.pop()

        backtrack(0, [0])
        return result