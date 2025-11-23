from typing import List

class Solution:
    def allPathsSourceTarget(self, graph: List[List[int]]) -> List[List[int]]:
        n = len(graph)
        target = n - 1

        results = []

        def dfs(node, current_path):
            current_path.append(node)

            if node == target:
                results.append(list(current_path))
            else:
                for neighbor in graph[node]:
                    dfs(neighbor, current_path)

            current_path.pop()

        dfs(0, [])
        return results